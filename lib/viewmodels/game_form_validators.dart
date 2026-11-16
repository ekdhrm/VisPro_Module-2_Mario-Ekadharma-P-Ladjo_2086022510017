/// Pure form rules so the add screen stays a view, not business logic.
abstract final class GameFormValidators {
  static String? title(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter a game title.';
    }
    return null;
  }

  static String? progress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Describe where you are in the game.';
    }
    return null;
  }

  static String? taskTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter a task title.';
    }
    return null;
  }

  /// The image link is optional, but when filled it must be a web link.
  static String? imageUrl(String? value) {
    final raw = value?.trim() ?? '';
    if (raw.isEmpty) return null;
    final uri = Uri.tryParse(raw);
    final isHttp =
        uri != null &&
        uri.isAbsolute &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
    if (!isHttp) return 'Enter a valid http or https link.';
    return null;
  }

  static String? completed(String? value) {
    final parsed = int.tryParse(value?.trim() ?? '');
    if (parsed == null) return 'Enter a whole number.';
    if (parsed < 0) return 'Completed objectives cannot be negative.';
    return null;
  }

  static String? total(String? value, {required String completed}) {
    final parsed = int.tryParse(value?.trim() ?? '');
    if (parsed == null || parsed <= 0) {
      return 'Enter a number greater than 0.';
    }
    final completedCount = int.tryParse(completed.trim()) ?? 0;
    if (completedCount > parsed) {
      return 'Total must be at least $completedCount.';
    }
    return null;
  }
}
