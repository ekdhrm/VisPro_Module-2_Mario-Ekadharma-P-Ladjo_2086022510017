import 'package:flutter_test/flutter_test.dart';
import 'package:game_progression_track/models/data/game_storage_service.dart';
import 'package:game_progression_track/models/data/local_game_repository.dart';
import 'package:game_progression_track/models/domain/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('a saved game is read back by a new repository instance', () async {
    final preferences = await SharedPreferences.getInstance();
    final firstRepository = LocalGameRepository(
      GameStorageService(preferences),
    );

    await firstRepository.addGame(
      const GameProgress(
        id: 'game-1',
        title: 'Stardew Valley',
        currentProgress: 'Spring, Year 2',
        completedObjectives: 12,
        totalObjectives: 15,
      ),
    );

    final secondRepository = LocalGameRepository(
      GameStorageService(preferences),
    );
    final games = await secondRepository.getGames();

    expect(games, hasLength(1));
    expect(games.single.id, 'game-1');
    expect(games.single.title, 'Stardew Valley');
    expect(games.single.completedObjectives, 12);
  });

  test('the seed is written once and is not duplicated', () async {
    final preferences = await SharedPreferences.getInstance();
    final repository = LocalGameRepository(
      GameStorageService(preferences),
      seed: const [
        GameProgress(
          id: 'seed-1',
          title: 'Until Then',
          currentProgress: 'Chapter 3',
          completedObjectives: 5,
          totalObjectives: 12,
        ),
      ],
    );

    final firstRead = await repository.getGames();
    final secondRead = await repository.getGames();

    expect(firstRead, hasLength(1));
    expect(secondRead, hasLength(1));
    expect(preferences.getString(GameStorageService.gamesKey), isNotNull);
  });

  test('corrupted storage is reported as a FormatException', () async {
    SharedPreferences.setMockInitialValues({
      GameStorageService.gamesKey: 'not valid json',
    });
    final preferences = await SharedPreferences.getInstance();
    final repository = LocalGameRepository(GameStorageService(preferences));

    expect(repository.getGames(), throwsA(isA<FormatException>()));
  });

  test('updateGame replaces the stored game by id', () async {
    final preferences = await SharedPreferences.getInstance();
    final repository = LocalGameRepository(GameStorageService(preferences));
    const original = GameProgress(
      id: 'game-1',
      title: 'Stardew Valley',
      currentProgress: 'Spring',
      completedObjectives: 1,
      totalObjectives: 4,
      tasks: [TodoItem(title: 'Fix the greenhouse', isCompleted: false)],
    );
    await repository.addGame(original);

    await repository.updateGame(
      original.copyWith(
        currentProgress: 'Summer',
        completedObjectives: 3,
        tasks: [const TodoItem(title: 'Fix the greenhouse', isCompleted: true)],
      ),
    );

    final reloaded = await LocalGameRepository(GameStorageService(preferences))
        .getGames();
    expect(reloaded.single.currentProgress, 'Summer');
    expect(reloaded.single.completedObjectives, 3);
    expect(reloaded.single.tasks.single.isCompleted, isTrue);
  });

  test('updateGame throws for an unknown id', () async {
    final preferences = await SharedPreferences.getInstance();
    final repository = LocalGameRepository(GameStorageService(preferences));

    expect(
      repository.updateGame(
        const GameProgress(
          id: 'missing',
          title: 'Missing',
          currentProgress: 'Nowhere',
          completedObjectives: 0,
          totalObjectives: 1,
        ),
      ),
      throwsA(isA<StateError>()),
    );
  });
}
