import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_progression_track/core/theme/zzz_theme.dart';
import 'package:game_progression_track/core/widgets/zzz_button.dart';
import 'package:game_progression_track/models/domain/game.dart';
import 'package:game_progression_track/views/add_game_view.dart';

void main() {
  testWidgets('add game saves tags and the image URL', (tester) async {
    GameProgress? result;
    await tester.pumpWidget(
      MaterialApp(
        theme: ZzzTheme.dark,
        home: Builder(
          builder: (context) => Center(
            child: ZzzButton(
              label: 'Open',
              onPressed: () async {
                result = await Navigator.push<GameProgress>(
                  context,
                  MaterialPageRoute<GameProgress>(
                    builder: (_) => const AddGameView(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('OPEN'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Coral Island');
    await tester.enterText(fields.at(1), 'Summer, Year 1');
    await tester.enterText(fields.at(4), 'Farming, Co-op, farming');
    await tester.enterText(fields.at(5), 'https://example.com/coral.png');
    await tester.ensureVisible(find.text('SAVE GAME'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('SAVE GAME'));
    await tester.pumpAndSettle();

    expect(result, isNotNull);
    expect(result!.title, 'Coral Island');
    expect(result!.badges, ['Farming', 'Co-op']);
    expect(result!.imageUrl, 'https://example.com/coral.png');
    expect(result!.completedObjectives, 0);
    expect(result!.totalObjectives, 10);
  });

  testWidgets('add game rejects a link that is not a web URL', (tester) async {
    await tester.pumpWidget(
      MaterialApp(theme: ZzzTheme.dark, home: const AddGameView()),
    );

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Coral Island');
    await tester.enterText(fields.at(1), 'Summer, Year 1');
    await tester.enterText(fields.at(5), 'not-a-link');
    await tester.ensureVisible(find.text('SAVE GAME'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('SAVE GAME'));
    await tester.pumpAndSettle();

    expect(find.text('Enter a valid http or https link.'), findsOneWidget);
  });
}
