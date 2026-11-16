import '../domain/game.dart';

/// Written once on first launch so the app does not start empty.
/// Delete this list if you prefer new installs to begin with no games.
const List<GameProgress> kSeedGames = [
  GameProgress(
    id: 'seed-stardew',
    title: 'Stardew Valley',
    currentProgress: 'Spring, Year 2',
    completedObjectives: 12,
    totalObjectives: 15,
    imageUrl: 'https://upload.wikimedia.org/wikipedia/en/f/fd/Logo_of_Stardew_Valley.png',
    badges: ['Farming', 'Co-op', 'Pixel Art'],
    tasks: [
      TodoItem(title: 'Reach level 10 Farming', isCompleted: true),
      TodoItem(title: 'Fix the Greenhouse', isCompleted: true),
      TodoItem(title: 'Catch a Legendary Fish', isCompleted: false),
    ],
  ),
  GameProgress(
    id: 'seed-coral-island',
    title: 'Coral Island',
    currentProgress: 'Summer, Year 1',
    completedObjectives: 8,
    totalObjectives: 16,
    badges: ['Farming', 'Simulation'],
  ),
  GameProgress(
    id: 'seed-space-unbound',
    title: 'A Space for the Unbound',
    currentProgress: 'Chapter 4',
    completedObjectives: 7,
    totalObjectives: 10,
    badges: ['Story Rich', 'Indie'],
  ),
  GameProgress(
    id: 'seed-until-then',
    title: 'Until Then',
    currentProgress: 'Chapter 3',
    completedObjectives: 5,
    totalObjectives: 12,
    badges: ['Visual Novel', 'Mystery'],
  ),
];
