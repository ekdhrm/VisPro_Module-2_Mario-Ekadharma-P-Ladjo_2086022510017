import 'package:flutter/material.dart';

import '../core/theme/zzz_shapes.dart';
import '../core/widgets/zzz_header.dart';
import '../core/widgets/zzz_text_field.dart';

/// Title, search field, and list heading at the top of the home screen.
class HomeIntro extends StatelessWidget {
  const HomeIntro({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
  });

  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ZzzHeader(
          title: 'Game Progress',
          subtitle: 'Keep track of where you left off.',
        ),
        const SizedBox(height: ZzzSpacing.lg),
        ZzzTextField(
          label: 'Search games',
          controller: searchController,
          onChanged: onSearchChanged,
        ),
        const SizedBox(height: ZzzSpacing.lg),
        Text('MY GAMES', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: ZzzSpacing.sm),
      ],
    );
  }
}
