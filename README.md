# Video Game Backlog Manager

## Case Study Overview
This application is built for Track A: The Fandom Vault. It is a Video Game Backlog Manager designed to help gamers track their game collection, organize items by completion status (Backlog, Playing, Finished, Dropped), and maintain a clean inventory.

## Features Implemented
- **Home Screen:** Displays the saved games, with loading, populated, empty, and error states.
- **Detail Screen:** Provides an expanded view of a specific game's progress, badges, and tasks.
- **Interactive tasks:** Tap a task row on the detail screen to mark it complete or incomplete, or add a new task.
- **Progress updates:** A dedicated screen edits the current progress and objective counts, then saves them.
- **Form Screen:** Adds a new game to the backlog with validation, plus optional tags (comma separated) and a thumbnail image URL.
- **Permanent data:** Games are stored as a JSON list in `shared_preferences` and reloaded on a cold start.
- **State handling:** `HomeCubit` and `DetailCubit` emit sealed, Equatable states, so every screen state is explicit and testable.
- **ZZZ design system:** Dark interface with token-based colors, chamfered panels, and `ZZZ*` shared widgets.

## Project Layers
- `lib/core/` - theme tokens (`zzz_colors`, `zzz_shapes`, `zzz_theme`) and shared `ZZZ*` widgets.
- `lib/models/domain/` - `GameProgress` and `TodoItem` entities plus the `GameRepository` contract.
- `lib/models/data/` - `LocalGameRepository`, `GameStorageService`, and the first-launch seed.
- `lib/viewmodels/` - `HomeCubit` and `DetailCubit` with their sealed states, tag parsing, and form validators.
- `lib/views/` - passive screens that render Cubit state and send user actions back.
- `lib/main.dart` - composition root. It is the only file that imports `models/data/`; views and viewmodels depend on `models/domain/` only.

## Persistence Check
1. Run `flutter run` on a device or emulator.
2. Add a game and confirm it appears on the home screen.
3. Open the game, tap a task to complete it, and update its progress.
4. Stop the app completely (swipe it away or stop the debug session).
5. Launch it again. The game, the checked task, and the new progress should still be there.
6. Storage key: `game_progression.games`.

The four sample games are written only on the very first launch. Clear app data if you want to see that seeding again.

## Setup Instructions
1. Clone this repository.
2. Run `flutter pub get` to fetch dependencies.
3. Run `flutter analyze` to ensure code is clean.
4. Run `flutter test` to run the model, repository, viewmodel, and widget tests.
5. Run `flutter run` to test on a local emulator.
6. To build the release application, run `flutter build apk --release`.

## Notes
- `android/gradle.properties` disables Kotlin incremental compilation because this project and the pub cache are on different Windows drives. Remove that line on a normal setup if you prefer.
- prefered to run with flutter run -d chrome --web-port=8080 --web-browser-flag="--user-data-dir=C:\Users\Hers\AppData\Local\FlutterChromeProfile" when i use chrome
