import 'game.dart';

/// The contract the rest of the app depends on. Views and viewmodels never
/// know how the data is stored.
abstract class GameRepository {
  Future<List<GameProgress>> getGames();

  Future<void> addGame(GameProgress game);

  /// Replaces the stored game that has the same id.
  Future<void> updateGame(GameProgress game);
}
