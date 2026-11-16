import 'package:flutter/material.dart';

import '../core/theme/zzz_shapes.dart';
import '../core/widgets/zzz_button.dart';
import '../core/widgets/zzz_stripe_background.dart';
import '../models/domain/game.dart';
import 'detail_badges.dart';
import 'detail_hero.dart';
import 'detail_summary.dart';
import 'detail_tasks.dart';

/// Composes the read-only parts of the detail screen with user actions.
class DetailContent extends StatelessWidget {
  const DetailContent({
    super.key,
    required this.game,
    required this.onToggleTask,
    required this.onAddTask,
    required this.onEditProgress,
  });

  final GameProgress game;
  final ValueChanged<int> onToggleTask;
  final VoidCallback onAddTask;
  final VoidCallback onEditProgress;

  @override
  Widget build(BuildContext context) {
    return ZzzStripeBackground(
      child: CustomScrollView(
        slivers: [
          DetailHero(title: game.title, imageUrl: game.imageUrl),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(ZzzSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailSummary(game: game),
                  const SizedBox(height: ZzzSpacing.md),
                  ZzzButton(
                    label: 'Update progress',
                    isPrimary: false,
                    onPressed: onEditProgress,
                  ),
                  if (game.badges.isNotEmpty) ...[
                    const SizedBox(height: ZzzSpacing.md),
                    DetailBadges(badges: game.badges),
                  ],
                  const SizedBox(height: ZzzSpacing.lg),
                  DetailTasks(
                    tasks: game.tasks,
                    onToggle: onToggleTask,
                    onAddTask: onAddTask,
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: ZzzSpacing.xl)),
        ],
      ),
    );
  }
}
