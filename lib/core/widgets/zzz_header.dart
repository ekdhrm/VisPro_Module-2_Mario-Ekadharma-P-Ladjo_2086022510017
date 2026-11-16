import 'package:flutter/material.dart';

import '../theme/zzz_colors.dart';
import '../theme/zzz_shapes.dart';

/// Screen title bar with an accent stripe and an optional subtitle.
class ZzzHeader extends StatelessWidget {
  const ZzzHeader({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: ZzzSpacing.xs,
              height: ZzzSpacing.xl,
              color: ZzzColors.accent,
            ),
            const SizedBox(width: ZzzSpacing.sm),
            Expanded(child: Text(title.toUpperCase(), style: text.titleLarge)),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: ZzzSpacing.sm),
          Text(subtitle!, style: text.bodySmall),
        ],
      ],
    );
  }
}
