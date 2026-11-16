import 'package:flutter/material.dart';

import '../theme/zzz_colors.dart';
import '../theme/zzz_shapes.dart';

/// Chamfered card container. Selected panels get an accent border.
class ZzzPanel extends StatelessWidget {
  const ZzzPanel({super.key, required this.child, this.isSelected = false});

  final Widget child;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ZzzSpacing.md),
      decoration: ShapeDecoration(
        color: isSelected ? ZzzColors.surfaceRaised : ZzzColors.surface,
        shape: zzzShape.copyWith(
          side: BorderSide(
            color: isSelected ? ZzzColors.accent : ZzzColors.outline,
            width: isSelected ? ZzzSizes.borderStrong : ZzzSizes.border,
          ),
        ),
      ),
      child: child,
    );
  }
}
