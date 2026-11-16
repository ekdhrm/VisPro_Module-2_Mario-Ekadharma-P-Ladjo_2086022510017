import 'package:flutter/material.dart';

import '../core/theme/zzz_shapes.dart';
import '../core/widgets/zzz_text_field.dart';
import '../viewmodels/game_form_validators.dart';

/// The three progress inputs shared by the add and update screens.
class ProgressFields extends StatelessWidget {
  const ProgressFields({
    super.key,
    required this.currentProgress,
    required this.completed,
    required this.total,
  });

  final TextEditingController currentProgress;
  final TextEditingController completed;
  final TextEditingController total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZzzTextField(
          label: 'Current progress',
          controller: currentProgress,
          validator: GameFormValidators.progress,
        ),
        const SizedBox(height: ZzzSpacing.md),
        ZzzTextField(
          label: 'Completed objectives',
          controller: completed,
          keyboardType: TextInputType.number,
          validator: GameFormValidators.completed,
        ),
        const SizedBox(height: ZzzSpacing.md),
        ZzzTextField(
          label: 'Total objectives',
          controller: total,
          keyboardType: TextInputType.number,
          validator: (value) =>
              GameFormValidators.total(value, completed: completed.text),
        ),
      ],
    );
  }
}
