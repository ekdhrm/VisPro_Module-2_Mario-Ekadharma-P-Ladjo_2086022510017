import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'models/data/game_seed.dart';
import 'models/data/game_storage_service.dart';
import 'models/data/local_game_repository.dart';
import 'models/domain/game_repository.dart';

/// Composition root: the only place that picks a storage implementation.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  final GameRepository repository = LocalGameRepository(
    GameStorageService(preferences),
    seed: kSeedGames,
  );
  runApp(GameProgressApp(repository: repository));
}
