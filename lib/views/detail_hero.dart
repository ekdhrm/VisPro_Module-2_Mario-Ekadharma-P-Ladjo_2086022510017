import 'package:flutter/material.dart';

import '../core/theme/zzz_colors.dart';
import '../core/theme/zzz_shapes.dart';

/// Collapsing hero header for the detail screen.
class DetailHero extends StatelessWidget {
  const DetailHero({super.key, required this.title, required this.imageUrl});

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return SliverAppBar(
      expandedHeight: ZzzSizes.heroHeight,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsetsDirectional.only(
          start: ZzzSpacing.md,
          bottom: ZzzSpacing.md,
        ),
        title: Text(
          title.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: text.headlineSmall?.copyWith(
            shadows: const [Shadow(blurRadius: 8)],
          ),
        ),
        background: _HeroImage(imageUrl: imageUrl),
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (imageUrl.isEmpty)
          const ColoredBox(color: ZzzColors.surface)
        else
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) =>
                const ColoredBox(color: ZzzColors.surface),
          ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                ZzzColors.background.withValues(alpha: 0.95),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
