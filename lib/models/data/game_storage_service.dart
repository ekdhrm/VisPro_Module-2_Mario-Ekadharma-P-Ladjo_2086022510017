import 'package:shared_preferences/shared_preferences.dart';

/// Wraps SharedPreferences so the storage plugin stays in one place.
/// A future switch to a database only replaces this class.
class GameStorageService {
  GameStorageService(this._preferences);

  /// Key used inside the platform's key-value store.
  static const String gamesKey = 'game_progression.games';

  final SharedPreferences _preferences;

  /// Returns null when the app has never saved anything.
  String? readGames() => _preferences.getString(gamesKey);

  Future<void> writeGames(String rawJson) async {
    final saved = await _preferences.setString(gamesKey, rawJson);
    if (!saved) {
      throw StateError('Local storage rejected the write.');
    }
  }
}
