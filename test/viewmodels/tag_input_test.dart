import 'package:flutter_test/flutter_test.dart';
import 'package:game_progression_track/viewmodels/tag_input.dart';

void main() {
  test('trims, drops empty parts, and removes duplicates', () {
    expect(TagInput.parse(' Farming, Co-op, , farming '), ['Farming', 'Co-op']);
  });

  test('returns an empty list for blank input', () {
    expect(TagInput.parse('   '), isEmpty);
  });
}
