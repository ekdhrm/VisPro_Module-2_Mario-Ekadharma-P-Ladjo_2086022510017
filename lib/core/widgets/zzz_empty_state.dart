import 'package:flutter/material.dart';

import '../theme/zzz_colors.dart';
import '../theme/zzz_shapes.dart';
import 'zzz_panel.dart';

/// Friendly message shown when a list has nothing to display.
class ZzzEmptyState extends StatelessWidget {
  const ZzzEmptyState({super.key, required this.message, required this.icon});

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ZzzPanel(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: ZzzSizes.iconLarge, color: ZzzColors.textMuted),
          const SizedBox(height: ZzzSpacing.md),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: ZzzColors.textMuted),
          ),
        ],
      ),
    );
  }
}
