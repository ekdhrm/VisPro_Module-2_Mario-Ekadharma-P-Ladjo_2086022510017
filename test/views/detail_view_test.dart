import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_progression_track/core/theme/zzz_theme.dart';
import 'package:game_progression_track/models/domain/game.dart';
import 'package:game_progression_track/views/detail_view.dart';

import '../helpers/fake_game_repository.dart';

const _game = GameProgress(
  id: 'game-1',
  title: 'Stardew Valley',
  currentProgress: 'Spring, Year 1',
  completedObjectives: 1,
  totalObjectives: 4,
  tasks: [TodoItem(title: 'Fix the greenhouse', isCompleted: false)],
);

Future<void> _pumpDetail(
  WidgetTester tester,
  FakeGameRepository repository,
) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: ZzzTheme.dark,
      home: DetailView(game: repository.games.first, repository: repository),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('tapping a task row toggles it and saves', (tester) async {
    final repository = FakeGameRepository(games: const [_game]);
    await _pumpDetail(tester, repository);

    await tester.tap(find.text('Fix the greenhouse'));
    await tester.pumpAndSettle();

    expect(repository.games.single.tasks.single.isCompleted, isTrue);
    expect(find.text('Completed'), findsOneWidget);
  });

  testWidgets('adding a task saves it and shows it', (tester) async {
    final repository = FakeGameRepository(games: const [_game]);
    await _pumpDetail(tester, repository);

    await tester.tap(find.text('ADD TASK'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextFormField),
      'Catch a legendary fish',
    );
    await tester.tap(find.text('SAVE TASK'));
    await tester.pumpAndSettle();

    expect(repository.games.single.tasks, hasLength(2));
    expect(find.text('Catch a legendary fish'), findsOneWidget);
  });

  testWidgets('updating progress saves the new numbers', (tester) async {
    final repository = FakeGameRepository(games: const [_game]);
    await _pumpDetail(tester, repository);

    await tester.tap(find.text('UPDATE PROGRESS'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Summer, Year 2');
    await tester.enterText(fields.at(1), '3');
    await tester.enterText(fields.at(2), '4');
    await tester.tap(find.text('SAVE PROGRESS'));
    await tester.pumpAndSettle();

    expect(repository.games.single.currentProgress, 'Summer, Year 2');
    expect(repository.games.single.completedObjectives, 3);
    expect(find.text('Summer, Year 2'), findsOneWidget);
  });
}
