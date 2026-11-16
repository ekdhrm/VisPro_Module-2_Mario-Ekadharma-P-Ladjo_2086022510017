import 'package:flutter/material.dart';

import '../core/theme/zzz_colors.dart';
import '../core/theme/zzz_shapes.dart';
import '../core/widgets/zzz_button.dart';
import '../core/widgets/zzz_empty_state.dart';
import '../core/widgets/zzz_list_tile.dart';
import '../core/widgets/zzz_panel.dart';
import '../models/domain/game.dart';

/// Interactive checklist: tap a row to toggle it, or add a new task.
class DetailTasks extends StatelessWidget {
  const DetailTasks({
    super.key,
    required this.tasks,
    required this.onToggle,
    required this.onAddTask,
  });

  final List<TodoItem> tasks;
  final ValueChanged<int> onToggle;
  final VoidCallback onAddTask;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('TASKS', style: text.headlineSmall),
            ZzzButton(
              label: 'Add task',
              isPrimary: false,
              onPressed: onAddTask,
            ),
          ],
        ),
        const SizedBox(height: ZzzSpacing.sm),
        if (tasks.isEmpty)
          const ZzzEmptyState(
            message: 'No tasks listed for this game yet.',
            icon: Icons.checklist_outlined,
          )
        else
          for (var index = 0; index < tasks.length; index++)
            Padding(
              padding: const EdgeInsets.only(bottom: ZzzSpacing.sm),
              child: ZzzPanel(
                child: ZzzListTile(
                  title: tasks[index].title,
                  subtitle: tasks[index].isCompleted
                      ? 'Completed'
                      : 'Not completed',
                  trailing: Icon(
                    tasks[index].isCompleted
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: tasks[index].isCompleted
                        ? ZzzColors.accent
                        : ZzzColors.textMuted,
                  ),
                  onTap: () => onToggle(index),
                ),
              ),
            ),
      ],
    );
  }
}
