import 'package:flutter/material.dart';

import '../core/theme/zzz_shapes.dart';
import '../core/widgets/zzz_panel.dart';
import '../models/domain/game.dart';
import 'game_thumbnail.dart';

/// One game row. All values are read-only and come from [game].
class GameCard extends StatelessWidget {
  const GameCard({super.key, required this.game, required this.onTap});

  final GameProgress game;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: ZzzPanel(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GameThumbnail(imageUrl: game.imageUrl),
            const SizedBox(width: ZzzSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: text.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: ZzzSpacing.xs),
                  Text(
                    game.currentProgress,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text.bodySmall,
                  ),
                  const SizedBox(height: ZzzSpacing.sm),
                  LinearProgressIndicator(value: game.progress),
                  const SizedBox(height: ZzzSpacing.xs),
                  Text(
                    '${game.completedObjectives} / ${game.totalObjectives} objectives',
                    style: text.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
