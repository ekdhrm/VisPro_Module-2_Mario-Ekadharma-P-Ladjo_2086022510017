import 'package:flutter_test/flutter_test.dart';
import 'package:game_progression_track/models/domain/game.dart';

void main() {
  group('GameProgress JSON', () {
    test('round-trips every field', () {
      const game = GameProgress(
        id: 'game-1',
        title: 'Stardew Valley',
        currentProgress: 'Spring, Year 2',
        completedObjectives: 12,
        totalObjectives: 15,
        imageUrl: 'https://example.com/logo.png',
        badges: ['Farming', 'Co-op'],
        tasks: [TodoItem(title: 'Fix the Greenhouse', isCompleted: true)],
      );

      final restored = GameProgress.fromJson(game.toJson());

      expect(restored.id, game.id);
      expect(restored.title, game.title);
      expect(restored.currentProgress, game.currentProgress);
      expect(restored.completedObjectives, game.completedObjectives);
      expect(restored.totalObjectives, game.totalObjectives);
      expect(restored.imageUrl, game.imageUrl);
      expect(restored.badges, game.badges);
      expect(restored.tasks.single.title, 'Fix the Greenhouse');
      expect(restored.tasks.single.isCompleted, isTrue);
    });

    test('uses safe defaults for missing fields', () {
      final game = GameProgress.fromJson(const {'title': 'Until Then'});

      expect(game.id, '');
      expect(game.title, 'Until Then');
      expect(game.currentProgress, '');
      expect(game.badges, isEmpty);
      expect(game.tasks, isEmpty);
    });

    test('clamps progress between 0 and 1', () {
      const tooMuch = GameProgress(
        id: 'game-2',
        title: 'Coral Island',
        currentProgress: 'Summer',
        completedObjectives: 20,
        totalObjectives: 10,
      );
      const noObjectives = GameProgress(
        id: 'game-3',
        title: 'Mystery Game',
        currentProgress: 'Start',
        completedObjectives: 0,
        totalObjectives: 0,
      );

      expect(tooMuch.progress, 1.0);
      expect(noObjectives.progress, 0.0);
    });

    test('copyWith keeps the id and untouched fields', () {
      const original = GameProgress(
        id: 'game-4',
        title: 'A Space for the Unbound',
        currentProgress: 'Chapter 4',
        completedObjectives: 7,
        totalObjectives: 10,
        imageUrl: 'https://example.com/space.png',
        badges: ['Story Rich', 'Indie'],
        tasks: [TodoItem(title: 'Talk to the cat', isCompleted: false)],
      );

      final updated = original.copyWith(
        completedObjectives: 8,
        tasks: [const TodoItem(title: 'Talk to the cat', isCompleted: true)],
      );

      expect(updated.id, original.id);
      expect(updated.title, original.title);
      expect(updated.imageUrl, original.imageUrl);
      expect(updated.badges, original.badges);
      expect(updated.currentProgress, original.currentProgress);
      expect(updated.completedObjectives, 8);
      expect(updated.tasks.single.isCompleted, isTrue);
    });

    test('Equatable compares values, not object identity', () {
      const first = GameProgress(
        id: 'game-5',
        title: 'Until Then',
        currentProgress: 'Chapter 3',
        completedObjectives: 5,
        totalObjectives: 12,
        badges: ['Visual Novel'],
        tasks: [TodoItem(title: 'Find the note', isCompleted: false)],
      );
      const second = GameProgress(
        id: 'game-5',
        title: 'Until Then',
        currentProgress: 'Chapter 3',
        completedObjectives: 5,
        totalObjectives: 12,
        badges: ['Visual Novel'],
        tasks: [TodoItem(title: 'Find the note', isCompleted: false)],
      );

      expect(first, second);
      expect(first.hashCode, second.hashCode);
      expect(first.tasks.single, second.tasks.single);
    });
  });
}
