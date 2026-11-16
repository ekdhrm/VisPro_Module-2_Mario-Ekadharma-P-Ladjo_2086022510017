import 'package:flutter/material.dart';

import '../core/theme/zzz_colors.dart';
import '../core/theme/zzz_shapes.dart';

/// Angular thumbnail with a fallback icon when the image cannot load.
class GameThumbnail extends StatelessWidget {
  const GameThumbnail({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ZzzSizes.thumbnailWidth,
      height: ZzzSizes.thumbnailHeight,
      decoration: const ShapeDecoration(
        color: ZzzColors.surfaceRaised,
        shape: zzzShape,
      ),
      child: ClipPath(
        clipper: const ShapeBorderClipper(shape: zzzShape),
        child: imageUrl.isEmpty
            ? const Icon(Icons.videogame_asset, color: ZzzColors.textMuted)
            : Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.image_not_supported,
                  color: ZzzColors.textMuted,
                ),
              ),
      ),
    );
  }
}
