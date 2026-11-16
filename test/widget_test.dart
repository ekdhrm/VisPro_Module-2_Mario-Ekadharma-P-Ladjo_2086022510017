import 'package:flutter_test/flutter_test.dart';
import 'package:game_progression_track/app.dart';

import 'helpers/fake_game_repository.dart';

void main() {
  testWidgets('shows the empty state on first launch', (tester) async {
    await tester.pumpWidget(GameProgressApp(repository: FakeGameRepository()));
    await tester.pumpAndSettle();

    expect(find.text('GAME PROGRESS'), findsOneWidget);
    expect(
      find.text('No games yet. Tap + to add your first game.'),
      findsOneWidget,
    );
  });

  testWidgets('the add button opens the add game form', (tester) async {
    await tester.pumpWidget(GameProgressApp(repository: FakeGameRepository()));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Add game'));
    await tester.pumpAndSettle();

    expect(find.text('ADD GAME'), findsOneWidget);
    expect(find.text('SAVE GAME'), findsOneWidget);
    expect(find.text('TAGS (COMMA SEPARATED)'), findsOneWidget);
    expect(find.text('IMAGE URL (OPTIONAL)'), findsOneWidget);
  });
}
