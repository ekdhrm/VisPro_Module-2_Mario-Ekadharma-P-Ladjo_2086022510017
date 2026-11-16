import 'package:flutter/material.dart';

import '../core/theme/zzz_colors.dart';
import '../core/widgets/zzz_panel.dart';

/// Bottom bar showing how many games and objectives are visible.
class ProgressSummary extends StatelessWidget {
  const ProgressSummary({
    super.key,
    required this.gameCount,
    required this.objectiveCount,
  });

  final int gameCount;
  final int objectiveCount;

  @override
  Widget build(BuildContext context) {
    final label = Theme.of(context).textTheme.labelMedium;
    return ZzzPanel(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$gameCount GAMES', style: label),
          Text(
            '$objectiveCount OBJECTIVES',
            style: label?.copyWith(color: ZzzColors.accent),
          ),
        ],
      ),
    );
  }
}
