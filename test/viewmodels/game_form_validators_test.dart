import 'package:flutter_test/flutter_test.dart';
import 'package:game_progression_track/viewmodels/game_form_validators.dart';

void main() {
  group('imageUrl', () {
    test('accepts empty input because the image is optional', () {
      expect(GameFormValidators.imageUrl(''), isNull);
      expect(GameFormValidators.imageUrl(null), isNull);
    });

    test('accepts http and https links', () {
      expect(
        GameFormValidators.imageUrl('https://example.com/cover.png'),
        isNull,
      );
      expect(GameFormValidators.imageUrl('http://example.com/a.jpg'), isNull);
    });

    test('rejects other schemes and plain text', () {
      expect(GameFormValidators.imageUrl('not-a-link'), isNotNull);
      expect(GameFormValidators.imageUrl('ftp://example.com/a.png'), isNotNull);
      expect(GameFormValidators.imageUrl('www.example.com/a.png'), isNotNull);
    });
  });

  test('taskTitle rejects blank input', () {
    expect(GameFormValidators.taskTitle('  '), isNotNull);
    expect(GameFormValidators.taskTitle('Find the greenhouse'), isNull);
  });
}
