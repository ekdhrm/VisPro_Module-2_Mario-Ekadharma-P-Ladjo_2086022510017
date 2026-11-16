import 'package:flutter/material.dart';

import '../core/theme/zzz_shapes.dart';
import '../core/widgets/zzz_button.dart';
import '../models/domain/game.dart';
import 'progress_fields.dart';

/// Edits the progress numbers of an existing game.
class UpdateProgressView extends StatefulWidget {
  const UpdateProgressView({super.key, required this.game});

  final GameProgress game;

  @override
  State<UpdateProgressView> createState() => _UpdateProgressViewState();
}

class _UpdateProgressViewState extends State<UpdateProgressView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _currentProgress;
  late final TextEditingController _completed;
  late final TextEditingController _total;

  @override
  void initState() {
    super.initState();
    _currentProgress = TextEditingController(text: widget.game.currentProgress);
    _completed = TextEditingController(
      text: '${widget.game.completedObjectives}',
    );
    _total = TextEditingController(text: '${widget.game.totalObjectives}');
  }

  @override
  void dispose() {
    _currentProgress.dispose();
    _completed.dispose();
    _total.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState?.validate() != true) return;
    Navigator.pop(
      context,
      widget.game.copyWith(
        currentProgress: _currentProgress.text.trim(),
        completedObjectives: int.parse(_completed.text.trim()),
        totalObjectives: int.parse(_total.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UPDATE PROGRESS')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(ZzzSpacing.md),
            children: [
              ProgressFields(
                currentProgress: _currentProgress,
                completed: _completed,
                total: _total,
              ),
              const SizedBox(height: ZzzSpacing.xl),
              ZzzButton(label: 'Save progress', onPressed: _save),
            ],
          ),
        ),
      ),
    );
  }
}
