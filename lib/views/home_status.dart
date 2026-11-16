import 'package:flutter/material.dart';

import '../core/theme/zzz_shapes.dart';
import '../core/widgets/zzz_button.dart';
import '../core/widgets/zzz_empty_state.dart';

/// Shared empty, error, and retry state for the home list.
class HomeStatus extends StatelessWidget {
  const HomeStatus({
    super.key,
    required this.message,
    required this.icon,
    this.actionLabel,
    this.onAction,
  });

  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ZzzSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ZzzEmptyState(message: message, icon: icon),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: ZzzSpacing.md),
            ZzzButton(label: actionLabel!, onPressed: onAction),
          ],
        ],
      ),
    );
  }
}
