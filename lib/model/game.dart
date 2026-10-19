class GameProgress {
  const GameProgress({
    required this.title,
    required this.currentProgress,
    required this.completedObjectives,
    required this.totalObjectives,
  });

  final String title;
  final String currentProgress;
  final int completedObjectives;
  final int totalObjectives;

  double get progress {
    if (totalObjectives == 0) return 0;
    return completedObjectives / totalObjectives;
  }
}