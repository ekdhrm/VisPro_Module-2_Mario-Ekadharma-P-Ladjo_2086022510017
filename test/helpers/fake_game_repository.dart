import 'package:game_progression_track/models/domain/game.dart';
import 'package:game_progression_track/models/domain/game_repository.dart';

/// In-memory repository for tests. It never touches shared_preferences.
class FakeGameRepository implements GameRepository {
  FakeGameRepository({
    List<GameProgress> games = const [],
    this.failReads = false,
    this.failWrites = false,
  }) : games = List<GameProgress>.from(games);

  List<GameProgress> games;
  final bool failReads;
  final bool failWrites;

  @override
  Future<List<GameProgress>> getGames() async {
    if (failReads) throw Exception('storage broke');
    return List<GameProgress>.from(games);
  }

  @override
  Future<void> addGame(GameProgress game) async {
    if (failWrites) throw Exception('storage broke');
    games = [...games, game];
  }

  @override
  Future<void> updateGame(GameProgress game) async {
    if (failWrites) throw Exception('storage broke');
    final index = games.indexWhere((existing) => existing.id == game.id);
    if (index == -1) throw StateError('missing game');
    games = List<GameProgress>.from(games)..[index] = game;
  }
}
