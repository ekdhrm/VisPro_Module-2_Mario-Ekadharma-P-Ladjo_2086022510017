import 'package:flutter_test/flutter_test.dart';
import 'package:game_progression_track/models/domain/game.dart';
import 'package:game_progression_track/viewmodels/home_cubit.dart';
import 'package:game_progression_track/viewmodels/home_state.dart';

import '../helpers/fake_game_repository.dart';

const _stardew = GameProgress(
  id: 'game-1',
  title: 'Stardew Valley',
  currentProgress: 'Spring',
  completedObjectives: 2,
  totalObjectives: 4,
);

const _coral = GameProgress(
  id: 'game-2',
  title: 'Coral Island',
  currentProgress: 'Summer',
  completedObjectives: 1,
  totalObjectives: 4,
);

void main() {
  test('load ends in HomeLoaded with the saved games', () async {
    final cubit = HomeCubit(FakeGameRepository(games: const [_stardew]));

    await cubit.load();

    final state = cubit.state;
    expect(state, isA<HomeLoaded>());
    expect((state as HomeLoaded).games.single.title, 'Stardew Valley');
    expect(state.gameCount, 1);
    expect(state.objectiveCount, 4);
  });

  test('the query filters visible games only', () async {
    final cubit = HomeCubit(
      FakeGameRepository(games: const [_stardew, _coral]),
    );
    await cubit.load();

    cubit.setQuery('coral');

    final state = cubit.state as HomeLoaded;
    expect(state.games, hasLength(2));
    expect(state.visibleGames, hasLength(1));
    expect(state.gameCount, 1);
    expect(state.objectiveCount, 4);
  });

  test('adding a game saves it and appends it', () async {
    final repository = FakeGameRepository(games: const [_stardew]);
    final cubit = HomeCubit(repository);
    await cubit.load();

    const newGame = GameProgress(
      id: 'game-3',
      title: 'Until Then',
      currentProgress: 'Chapter 1',
      completedObjectives: 0,
      totalObjectives: 5,
    );
    final saved = await cubit.addGame(newGame);

    expect(saved, isTrue);
    expect(repository.games, hasLength(2));
    expect((cubit.state as HomeLoaded).games.last.id, 'game-3');
  });

  test(
    'a failed read ends in HomeFailure with a user-facing message',
    () async {
      final cubit = HomeCubit(FakeGameRepository(failReads: true));

      await cubit.load();

      expect(
        cubit.state,
        const HomeFailure(
          'Your games could not be loaded. Check your storage and try again.',
        ),
      );
    },
  );

  test('a failed save returns false and keeps the list unchanged', () async {
    final repository = FakeGameRepository(
      games: const [_stardew],
      failWrites: true,
    );
    final cubit = HomeCubit(repository);
    await cubit.load();

    final saved = await cubit.addGame(_coral);

    expect(saved, isFalse);
    expect((cubit.state as HomeLoaded).games, [_stardew]);
  });

  test('refresh picks up an update saved elsewhere', () async {
    final repository = FakeGameRepository(games: const [_stardew]);
    final cubit = HomeCubit(repository);
    await cubit.load();

    await repository.updateGame(_stardew.copyWith(completedObjectives: 4));
    await cubit.refresh();

    final state = cubit.state as HomeLoaded;
    expect(state.games.single.completedObjectives, 4);
  });

  test('states with the same data are equal', () {
    expect(const HomeLoading(), const HomeLoading());
    expect(const HomeLoaded([_stardew]), const HomeLoaded([_stardew]));
    expect(const HomeFailure('same'), const HomeFailure('same'));
    expect(const HomeFailure('one'), isNot(const HomeFailure('two')));
  });
}
