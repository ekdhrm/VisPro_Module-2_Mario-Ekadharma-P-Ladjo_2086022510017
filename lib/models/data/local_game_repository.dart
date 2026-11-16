import 'dart:convert';

import '../domain/game.dart';
import '../domain/game_repository.dart';
import 'game_storage_service.dart';

/// Stores games as one JSON list inside SharedPreferences.
class LocalGameRepository implements GameRepository {
  LocalGameRepository(this._storage, {this.seed = const []});

  final GameStorageService _storage;

  /// First-launch data. Only written when storage has no games yet.
  final List<GameProgress> seed;

  @override
  Future<List<GameProgress>> getGames() async {
    final raw = _storage.readGames();
    if (raw == null) {
      if (seed.isNotEmpty) await _write(seed);
      return List<GameProgress>.from(seed);
    }
    final decoded = jsonDecode(raw);
    if (decoded is! List) {
      throw const FormatException('Stored games are not a JSON list.');
    }
    return decoded
        .whereType<Map<String, dynamic>>()
        .map(GameProgress.fromJson)
        .toList(growable: false);
  }

  @override
  Future<void> addGame(GameProgress game) async {
    final games = await getGames();
    await _write([...games, game]);
  }

  @override
  Future<void> updateGame(GameProgress game) async {
    final games = await getGames();
    final index = games.indexWhere((existing) => existing.id == game.id);
    if (index == -1) {
      throw StateError('No saved game with id ${game.id}.');
    }
    final updated = List<GameProgress>.from(games)..[index] = game;
    await _write(updated);
  }

  Future<void> _write(List<GameProgress> games) async {
    final raw = jsonEncode(games.map((game) => game.toJson()).toList());
    await _storage.writeGames(raw);
  }
}
