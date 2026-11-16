import 'package:equatable/equatable.dart';

/// One checklist item inside a game.
class TodoItem extends Equatable {
  const TodoItem({required this.title, required this.isCompleted});

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      title: json['title'] as String? ?? '',
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  final String title;
  final bool isCompleted;

  TodoItem copyWith({String? title, bool? isCompleted}) {
    return TodoItem(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'isCompleted': isCompleted};
  }

  @override
  List<Object?> get props => [title, isCompleted];
}

/// A game in the backlog. The [id] keeps stored records stable across restarts.
class GameProgress extends Equatable {
  const GameProgress({
    required this.id,
    required this.title,
    required this.currentProgress,
    required this.completedObjectives,
    required this.totalObjectives,
    this.imageUrl = '',
    this.badges = const [],
    this.tasks = const [],
  });

  /// Rebuilds a game from stored JSON, falling back to safe defaults.
  factory GameProgress.fromJson(Map<String, dynamic> json) {
    return GameProgress(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      currentProgress: json['currentProgress'] as String? ?? '',
      completedObjectives: (json['completedObjectives'] as num?)?.toInt() ?? 0,
      totalObjectives: (json['totalObjectives'] as num?)?.toInt() ?? 0,
      imageUrl: json['imageUrl'] as String? ?? '',
      badges: (json['badges'] as List<dynamic>? ?? const [])
          .whereType<String>()
          .toList(growable: false),
      tasks: (json['tasks'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(TodoItem.fromJson)
          .toList(growable: false),
    );
  }

  final String id;
  final String title;
  final String currentProgress;
  final int completedObjectives;
  final int totalObjectives;
  final String imageUrl;
  final List<String> badges;
  final List<TodoItem> tasks;

  /// Always between 0 and 1, even if stored data is inconsistent.
  double get progress {
    if (totalObjectives <= 0) return 0;
    return (completedObjectives / totalObjectives).clamp(0.0, 1.0).toDouble();
  }

  /// Returns a new game with changed fields. The [id] never changes.
  GameProgress copyWith({
    String? title,
    String? currentProgress,
    int? completedObjectives,
    int? totalObjectives,
    String? imageUrl,
    List<String>? badges,
    List<TodoItem>? tasks,
  }) {
    return GameProgress(
      id: id,
      title: title ?? this.title,
      currentProgress: currentProgress ?? this.currentProgress,
      completedObjectives: completedObjectives ?? this.completedObjectives,
      totalObjectives: totalObjectives ?? this.totalObjectives,
      imageUrl: imageUrl ?? this.imageUrl,
      badges: badges ?? this.badges,
      tasks: tasks ?? this.tasks,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'currentProgress': currentProgress,
      'completedObjectives': completedObjectives,
      'totalObjectives': totalObjectives,
      'imageUrl': imageUrl,
      'badges': badges,
      'tasks': tasks.map((task) => task.toJson()).toList(growable: false),
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    currentProgress,
    completedObjectives,
    totalObjectives,
    imageUrl,
    badges,
    tasks,
  ];
}
