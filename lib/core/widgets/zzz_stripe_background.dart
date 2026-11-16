import 'package:flutter/material.dart';

import '../theme/zzz_colors.dart';
import '../theme/zzz_shapes.dart';

/// Subtle diagonal stripes painted behind a screen. Keep opacity under 0.08.
class ZzzStripeBackground extends StatelessWidget {
  const ZzzStripeBackground({
    super.key,
    required this.child,
    this.opacity = 0.06,
  });

  final Widget child;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(painter: _StripePainter(opacity: opacity)),
          ),
        ),
        child,
      ],
    );
  }
}

class _StripePainter extends CustomPainter {
  const _StripePainter({required this.opacity});

  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ZzzColors.outline.withValues(alpha: opacity)
      ..strokeWidth = ZzzSizes.border;
    for (double x = -size.height; x < size.width; x += ZzzSizes.stripeGap) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_StripePainter oldDelegate) {
    return oldDelegate.opacity != opacity;
  }
}
