import 'package:flutter/material.dart';

import '../core/theme/zzz_shapes.dart';
import '../core/widgets/zzz_panel.dart';
import '../models/domain/game.dart';

/// Progress and completion numbers for one game.
class DetailSummary extends StatelessWidget {
  const DetailSummary({super.key, required this.game});

  final GameProgress game;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final progressLabel = game.currentProgress.trim().isEmpty
        ? 'Not set yet'
        : game.currentProgress;
    return ZzzPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('CURRENT PROGRESS', style: text.labelMedium),
          const SizedBox(height: ZzzSpacing.sm),
          Text(progressLabel, style: text.headlineSmall),
          const Divider(),
          Text('COMPLETION', style: text.labelMedium),
          const SizedBox(height: ZzzSpacing.sm),
          LinearProgressIndicator(value: game.progress),
          const SizedBox(height: ZzzSpacing.xs),
          Text(
            '${game.completedObjectives} of ${game.totalObjectives} '
            'objectives completed',
            style: text.bodySmall,
          ),
        ],
      ),
    );
  }
}
