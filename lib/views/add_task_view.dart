import 'package:flutter/material.dart';

import '../core/theme/zzz_shapes.dart';
import '../core/widgets/zzz_button.dart';
import '../core/widgets/zzz_text_field.dart';
import '../models/domain/game.dart';
import '../viewmodels/game_form_validators.dart';

/// Collects one task title and returns a new, incomplete task.
class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState?.validate() != true) return;
    Navigator.pop(
      context,
      TodoItem(title: _title.text.trim(), isCompleted: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ADD TASK')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(ZzzSpacing.md),
            children: [
              ZzzTextField(
                label: 'Task title',
                controller: _title,
                validator: GameFormValidators.taskTitle,
              ),
              const SizedBox(height: ZzzSpacing.xl),
              ZzzButton(label: 'Save task', onPressed: _save),
            ],
          ),
        ),
      ),
    );
  }
}
