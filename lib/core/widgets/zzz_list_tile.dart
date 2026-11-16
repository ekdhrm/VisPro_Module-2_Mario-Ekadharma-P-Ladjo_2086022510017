import 'package:flutter/material.dart';

import '../theme/zzz_shapes.dart';

/// One row inside a list. Keeps a 48 by 48 minimum tap target.
class ZzzListTile extends StatelessWidget {
  const ZzzListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: ZzzSizes.minTapTarget),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: ZzzSpacing.sm),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: text.bodyMedium),
                    if (subtitle != null) ...[
                      const SizedBox(height: ZzzSpacing.xs),
                      Text(subtitle!, style: text.bodySmall),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: ZzzSpacing.sm),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
