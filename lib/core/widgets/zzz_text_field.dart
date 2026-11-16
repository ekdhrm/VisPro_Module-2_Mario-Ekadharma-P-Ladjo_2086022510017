import 'package:flutter/material.dart';

import '../theme/zzz_colors.dart';
import '../theme/zzz_shapes.dart';

/// Input with a chamfered surface and an accent focus border.
class ZzzTextField extends StatefulWidget {
  const ZzzTextField({
    super.key,
    required this.label,
    required this.controller,
    this.errorText,
    this.onChanged,
    this.validator,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;

  @override
  State<ZzzTextField> createState() => _ZzzTextFieldState();
}

class _ZzzTextFieldState extends State<ZzzTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final focused = _focusNode.hasFocus;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label.toUpperCase(), style: theme.textTheme.labelMedium),
        const SizedBox(height: ZzzSpacing.xs),
        Container(
          constraints: const BoxConstraints(minHeight: ZzzSizes.minTapTarget),
          padding: const EdgeInsets.symmetric(
            horizontal: ZzzSpacing.md,
            vertical: ZzzSpacing.xs,
          ),
          decoration: ShapeDecoration(
            color: ZzzColors.surface,
            shape: zzzShape.copyWith(
              side: BorderSide(
                color: focused ? ZzzColors.accent : ZzzColors.outline,
                width: focused ? ZzzSizes.borderStrong : ZzzSizes.border,
              ),
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            onChanged: widget.onChanged,
            style: theme.textTheme.bodyMedium,
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              errorText: widget.errorText,
            ),
          ),
        ),
      ],
    );
  }
}
