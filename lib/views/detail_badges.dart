import 'package:flutter/material.dart';

import '../core/theme/zzz_colors.dart';
import '../core/theme/zzz_shapes.dart';
import '../core/widgets/zzz_tag.dart';

/// Genre badges. Muted so the accent stays reserved for actions and numbers.
class DetailBadges extends StatelessWidget {
  const DetailBadges({super.key, required this.badges});

  final List<String> badges;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: ZzzSpacing.sm,
      runSpacing: ZzzSpacing.sm,
      children: [
        for (final badge in badges)
          ZzzTag(label: badge, color: ZzzColors.textMuted),
      ],
    );
  }
}
