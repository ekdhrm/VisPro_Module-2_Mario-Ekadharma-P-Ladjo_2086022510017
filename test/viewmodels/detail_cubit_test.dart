import 'package:flutter_test/flutter_test.dart';
import 'package:game_progression_track/models/domain/game.dart';
import 'package:game_progression_track/viewmodels/detail_cubit.dart';
import 'package:game_progression_track/viewmodels/detail_state.dart';

import '../helpers/fake_game_repository.dart';

const _game = GameProgress(
  id: 'game-1',
  title: 'Stardew Valley',
  currentProgress: 'Spring',
  completedObjectives: 1,
  totalObjectives: 4,
  tasks: [TodoItem(title: 'Fix the greenhouse', isCompleted: false)],
);

void main() {
  test('toggling a task saves it and ends in DetailReady', () async {
    final repository = FakeGameRepository(games: const [_game]);
    final cubit = DetailCubit(repository, _game);

    await cubit.toggleTask(0);

    expect(cubit.state, isA<DetailReady>());
    expect(cubit.state.game.tasks.single.isCompleted, isTrue);
    expect(repository.games.single.tasks.single.isCompleted, isTrue);
  });

  test('adding a task appends it and saves', () async {
    final repository = FakeGameRepository(games: const [_game]);
    final cubit = DetailCubit(repository, _game);

    await cubit.addTask(
      const TodoItem(title: 'Catch a legendary fish', isCompleted: false),
    );

    expect(cubit.state.game.tasks, hasLength(2));
    expect(cubit.state.game.tasks.last.title, 'Catch a legendary fish');
    expect(repository.games.single.tasks, hasLength(2));
  });

  test('updateProgress saves the new numbers', () async {
    final repository = FakeGameRepository(games: const [_game]);
    final cubit = DetailCubit(repository, _game);

    await cubit.updateProgress(
      _game.copyWith(currentProgress: 'Summer, Year 2', completedObjectives: 3),
    );

    expect(cubit.state.game.currentProgress, 'Summer, Year 2');
    expect(repository.games.single.completedObjectives, 3);
  });

  test('updateProgress ignores a game with a different id', () async {
    final repository = FakeGameRepository(games: const [_game]);
    final cubit = DetailCubit(repository, _game);

    await cubit.updateProgress(
      const GameProgress(
        id: 'other-game',
        title: 'Other game',
        currentProgress: 'Nowhere',
        completedObjectives: 0,
        totalObjectives: 1,
      ),
    );

    expect(cubit.state, const DetailReady(_game));
    expect(repository.games.single.currentProgress, 'Spring');
  });

  test('a failed save ends in DetailFailure and keeps the old game', () async {
    final repository = FakeGameRepository(
      games: const [_game],
      failWrites: true,
    );
    final cubit = DetailCubit(repository, _game);

    await cubit.toggleTask(0);

    final state = cubit.state;
    expect(state, isA<DetailFailure>());
    expect((state as DetailFailure).message, contains('could not be saved'));
    expect(state.game.tasks.single.isCompleted, isFalse);
  });

  test('states with the same data are equal', () {
    expect(const DetailReady(_game), const DetailReady(_game));
    expect(const DetailSaving(_game), const DetailSaving(_game));
    expect(
      const DetailFailure(_game, 'same'),
      const DetailFailure(_game, 'same'),
    );
  });
}
