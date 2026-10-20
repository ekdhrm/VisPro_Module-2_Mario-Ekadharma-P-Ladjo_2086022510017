import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'model/game.dart';
import 'screens/home_screen.dart';

void main() => runApp(const GameProgressApp());

const List<GameProgress> kNormalGames = [
  GameProgress(
    title: 'Stardew Valley',
    currentProgress: 'Spring, Year 2',
    completedObjectives: 12,
    totalObjectives: 15,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/en/f/fd/Logo_of_Stardew_Valley.png',
    badges: ['Farming', 'Co-op', 'Pixel Art'],
    tasks: [
      TodoItem(title: 'Reach level 10 Farming', isCompleted: true),
      TodoItem(title: 'Fix the Greenhouse', isCompleted: true),
      TodoItem(title: 'Catch a Legendary Fish', isCompleted: false),
    ],
  ),
  GameProgress(
    title: 'Coral Island',
    currentProgress: 'Summer, Year 1',
    completedObjectives: 8,
    totalObjectives: 16,
    badges: ['Farming', 'Simulation'],
  ),
  GameProgress(
    title: 'A Space for the Unbound',
    currentProgress: 'Chapter 4',
    completedObjectives: 7,
    totalObjectives: 10,
    badges: ['Story Rich', 'Indie'],
  ),
  GameProgress(
    title: 'Until Then',
    currentProgress: 'Chapter 3',
    completedObjectives: 5,
    totalObjectives: 12,
    badges: ['Visual Novel', 'Mystery'],
  ),
];

class GameProgressApp extends StatelessWidget {
  const GameProgressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Tracker',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // Automatically switches based on device settings
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: PointerDeviceKind.values.toSet(),
      ),
      home: const HomeScreen(games: kNormalGames),
    );
  }
}