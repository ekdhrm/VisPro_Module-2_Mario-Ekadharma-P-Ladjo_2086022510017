import 'package:flutter/material.dart';

class ProgressSummary extends StatelessWidget {
  const ProgressSummary({
    super.key,
    required this.gameCount,
    required this.objectiveCount,
  });

  final int gameCount;
  final int objectiveCount;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$gameCount games',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '$objectiveCount objectives',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}