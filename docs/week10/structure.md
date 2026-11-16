# Architectural Breakdown

The Module 2 update keeps Module 1's folder convention but moves business state and storage out of the widgets. The AFL 2 refactor adds Cubits, sealed states, and a domain/data split.

```
lib/
  main.dart      composition root and dependency injection
  app.dart       MaterialApp, theme, and root route
  core/
    theme/       zzz_colors.dart, zzz_shapes.dart, zzz_theme.dart
    widgets/     zzz_button.dart, zzz_panel.dart, zzz_header.dart ...
  models/
    domain/      game.dart, game_repository.dart
    data/        local_game_repository.dart, game_storage_service.dart,
                 game_seed.dart
  viewmodels/
    home_cubit.dart, home_state.dart
    detail_cubit.dart, detail_state.dart
    tag_input.dart, game_form_validators.dart
  views/
    home_view.dart, home_body.dart, home_intro.dart, home_status.dart
    game_list.dart, game_card.dart, game_thumbnail.dart
    detail_view.dart, detail_content.dart, detail_hero.dart,
    detail_summary.dart, detail_badges.dart, detail_tasks.dart
    add_game_view.dart, add_task_view.dart, update_progress_view.dart,
    progress_fields.dart, progress_summary.dart
```

## Layers

- **`lib/core/`**: Only genuinely shared code. `theme/` owns every color, shape, spacing, duration, and text style used by the UI. `widgets/` holds the `Zzz*` components from DESIGN.md. No screen defines its own colors or sizes.
- **`lib/models/domain/`**: Pure data and the contract. `game.dart` defines `GameProgress` and `TodoItem`; both extend `Equatable`, keep `toJson`/`fromJson`, and use `copyWith` for edits. `game_repository.dart` is the interface the app depends on (`getGames`, `addGame`, `updateGame`). Nothing here imports Flutter.
- **`lib/models/data/`**: The implementations. `local_game_repository.dart` stores one JSON list inside `shared_preferences`; `game_storage_service.dart` wraps the plugin; `game_seed.dart` holds first-launch data. Only `main.dart` imports this folder, so swapping storage means changing one file and the composition root.
- **`lib/viewmodels/`**: `HomeCubit` and `DetailCubit` own business state and emit sealed, Equatable states. Every `await` is followed by an `isClosed` check before emitting. `tag_input.dart` parses the comma-separated tags field, and `game_form_validators.dart` keeps form rules out of widgets. The three forms keep only local input state, not business state.
- **`lib/views/`**: Passive widgets. `HomeView` and `DetailView` create and close their Cubit, then render state with `BlocBuilder` / `BlocConsumer`. `HomeBody` switches over `HomeState` exhaustively. `AddGameView`, `AddTaskView`, and `UpdateProgressView` collect input, return a model, and never touch storage. All controllers and Cubits are disposed.

## State transitions

```
HomeState
  HomeLoading  -> HomeLoaded | HomeFailure
  HomeFailure  -> HomeLoading   (retry)
  HomeLoaded   -> HomeLoaded    (search query or a new game)

DetailState
  DetailReady  -> DetailSaving -> DetailReady    (saved)
                               -> DetailFailure  (old game kept, snackbar shown)
```

`HomeLoaded` carries the full game list and the search query; `visibleGames`, `gameCount`, and `objectiveCount` are derived from them. `DetailFailure` keeps the last saved game so the screen never goes blank after a failed save.

## Data flow

```
HomeView -> HomeCubit -> GameRepository -> LocalGameRepository
         -> GameStorageService -> SharedPreferences (JSON string)

DetailView -> DetailCubit -> GameRepository.updateGame(...)
AddGameView / AddTaskView / UpdateProgressView
         -> return a model to the screen that opened them
```

Views and viewmodels import only `models/domain/`. `main.dart` is the composition root: it builds `LocalGameRepository`, injects it into `GameProgressApp`, and the views pass it to their Cubits.

## Persistence

- Key: `game_progression.games`.
- Value: one JSON array containing every game, including tags (`badges`), `imageUrl`, and tasks.
- First launch: the repository writes `kSeedGames`, then returns them.
- Later launches: the repository decodes the stored array. A malformed value raises `FormatException`, and `HomeCubit` turns that into a retry message.
- Add: the repository saves first; `HomeCubit` emits the new list only after the save succeeds.
- Update: `updateGame` replaces the stored game with the same `id`, or throws `StateError` if no game matches. Task toggles, new tasks, and progress edits all go through it.
- Task completion and the objective counts are independent: checking a task does not change `completedObjectives`.
- Cold-start check: add a game, check a task, update its progress, kill the app, reopen it, and confirm all three changes are still there.
