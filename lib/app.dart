import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'core/theme/zzz_theme.dart';
import 'models/domain/game_repository.dart';
import 'views/home_view.dart';

/// Root widget. It knows the repository interface, never its storage.
class GameProgressApp extends StatelessWidget {
  const GameProgressApp({super.key, required this.repository});

  final GameRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Tracker',
      debugShowCheckedModeBanner: false,
      theme: ZzzTheme.dark,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: PointerDeviceKind.values.toSet(),
      ),
      home: HomeView(repository: repository),
    );
  }
}
