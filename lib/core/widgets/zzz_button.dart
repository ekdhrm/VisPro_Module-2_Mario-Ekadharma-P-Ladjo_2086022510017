import 'package:flutter/material.dart';

import '../theme/zzz_colors.dart';
import '../theme/zzz_shapes.dart';
import '../theme/zzz_theme.dart';

/// Primary or secondary action with a chamfered shape and press feedback.
class ZzzButton extends StatefulWidget {
  const ZzzButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isPrimary = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;

  @override
  State<ZzzButton> createState() => _ZzzButtonState();
}

class _ZzzButtonState extends State<ZzzButton> {
  bool _pressed = false;

  bool get _enabled => widget.onPressed != null;

  Color get _fill {
    if (!_enabled) return ZzzColors.outline;
    return widget.isPrimary ? ZzzColors.accent : Colors.transparent;
  }

  Color get _ink {
    if (!_enabled) return ZzzColors.textMuted;
    return widget.isPrimary ? ZzzColors.onAccent : ZzzColors.accent;
  }

  void _setPressed(bool value) {
    if (_enabled && _pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelMedium;
    return Semantics(
      button: true,
      enabled: _enabled,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onPressed,
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        child: AnimatedScale(
          scale: _pressed ? 0.97 : 1,
          duration: zzzDuration,
          curve: zzzCurve,
          child: Container(
            constraints: const BoxConstraints(minHeight: ZzzSizes.minTapTarget),
            padding: const EdgeInsets.symmetric(horizontal: ZzzSpacing.lg),
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              color: _fill,
              shape: zzzShape.copyWith(
                side: widget.isPrimary || !_enabled
                    ? BorderSide.none
                    : const BorderSide(color: ZzzColors.accent),
              ),
            ),
            child: Text(
              widget.label.toUpperCase(),
              style: labelStyle?.copyWith(color: _ink),
            ),
          ),
        ),
      ),
    );
  }
}
