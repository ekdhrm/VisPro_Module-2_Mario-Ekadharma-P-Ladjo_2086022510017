/// Parses the comma-separated tags field into clean, unique tags.
abstract final class TagInput {
  static List<String> parse(String raw) {
    final tags = <String>[];
    final seen = <String>{};
    for (final part in raw.split(',')) {
      final tag = part.trim();
      if (tag.isEmpty) continue;
      if (seen.add(tag.toLowerCase())) tags.add(tag);
    }
    return tags;
  }
}
