import 'package:flutter/material.dart';
import '../model/game.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.game});

  final GameProgress game;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Faded Hero Thumbnail
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                game.title,
                style: const TextStyle(shadows: [Shadow(blurRadius: 5)]),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  if (game.imageUrl.isNotEmpty)
                    Image.network(
                      game.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) =>
                          Container(color: colorScheme.surface),
                    )
                  else
                    Container(color: colorScheme.surface),
                  // Fade Gradient Overlay
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          colorScheme.surface.withValues(alpha: 0.95),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Game Stats & Badges
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current Progress', style: text.labelLarge),
                  const SizedBox(height: 8),
                  Text(game.currentProgress, style: text.headlineSmall),
                  const Divider(height: 24),
                  if (game.badges.isNotEmpty) ...[
                    Text('Badges', style: text.labelLarge),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: game.badges
                          .map((badge) => Chip(
                                label: Text(badge),
                                backgroundColor: colorScheme.secondaryContainer,
                                side: BorderSide.none,
                              ))
                          .toList(),
                    ),
                    const Divider(height: 24),
                  ],
                  Text('Completion Status', style: text.labelLarge),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(value: game.progress),
                  const SizedBox(height: 8),
                  Text(
                    '${game.completedObjectives} of ${game.totalObjectives} objectives completed',
                    style: text.bodyMedium,
                  ),
                  const SizedBox(height: 32),
                  Text('Achievements & Tasks', style: text.titleMedium),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          // Achievement / To-Do Cards
          if (game.tasks.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text('No specific tasks listed.', style: text.bodyMedium),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final task = game.tasks[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      color: colorScheme.surfaceContainerHighest,
                      elevation: 0,
                      child: ListTile(
                        leading: Icon(
                          task.isCompleted
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: task.isCompleted
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                        ),
                        title: Text(
                          task.title,
                          style: TextStyle(
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: task.isCompleted
                                ? colorScheme.onSurfaceVariant
                                : colorScheme.onSurface,
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: game.tasks.length,
                ),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)), // Bottom padding
        ],
      ),
    );
  }
}