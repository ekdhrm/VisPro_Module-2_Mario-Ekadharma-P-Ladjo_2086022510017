import 'package:flutter/material.dart';

import '../theme/zzz_colors.dart';
import '../theme/zzz_shapes.dart';

/// Small skewed status label. Always pair it with text, never color alone.
class ZzzTag extends StatelessWidget {
  const ZzzTag({super.key, required this.label, this.color = ZzzColors.accent});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: zzzTagAngle,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: ZzzSpacing.sm,
          vertical: ZzzSpacing.xs,
        ),
        decoration: ShapeDecoration(
          color: color.withValues(alpha: 0.12),
          shape: zzzShape.copyWith(
            side: BorderSide(color: color, width: ZzzSizes.border),
          ),
        ),
        child: Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(color: color),
        ),
      ),
    );
  }
}
