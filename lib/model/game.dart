class TodoItem {
  final String title;
  final bool isCompleted;

  const TodoItem({required this.title, required this.isCompleted});
}

class GameProgress {
  const GameProgress({
    required this.title,
    required this.currentProgress,
    required this.completedObjectives,
    required this.totalObjectives,
    this.imageUrl = '', // Defaults to empty so old data doesn't break
    this.badges = const [],
    this.tasks = const [],
  });

  final String title;
  final String currentProgress;
  final int completedObjectives;
  final int totalObjectives;
  final String imageUrl;
  final List<String> badges;
  final List<TodoItem> tasks;

  double get progress {
    if (totalObjectives == 0) return 0;
    return completedObjectives / totalObjectives;
  }
}