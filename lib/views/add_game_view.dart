import 'package:flutter/material.dart';

import '../core/theme/zzz_shapes.dart';
import '../core/widgets/zzz_button.dart';
import '../core/widgets/zzz_text_field.dart';
import '../models/domain/game.dart';
import '../viewmodels/game_form_validators.dart';
import '../viewmodels/tag_input.dart';
import 'progress_fields.dart';

/// Form that collects a new game and returns it to the home screen.
class AddGameView extends StatefulWidget {
  const AddGameView({super.key});

  @override
  State<AddGameView> createState() => _AddGameViewState();
}

class _AddGameViewState extends State<AddGameView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _currentProgress = TextEditingController();
  final TextEditingController _completed = TextEditingController(text: '0');
  final TextEditingController _total = TextEditingController(text: '10');
  final TextEditingController _tags = TextEditingController();
  final TextEditingController _imageUrl = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _currentProgress.dispose();
    _completed.dispose();
    _total.dispose();
    _tags.dispose();
    _imageUrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState?.validate() != true) return;
    final game = GameProgress(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: _title.text.trim(),
      currentProgress: _currentProgress.text.trim(),
      completedObjectives: int.parse(_completed.text.trim()),
      totalObjectives: int.parse(_total.text.trim()),
      imageUrl: _imageUrl.text.trim(),
      badges: TagInput.parse(_tags.text),
    );
    Navigator.pop(context, game);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ADD GAME')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(ZzzSpacing.md),
            children: [
              ZzzTextField(
                label: 'Game title',
                controller: _title,
                validator: GameFormValidators.title,
              ),
              const SizedBox(height: ZzzSpacing.md),
              ProgressFields(
                currentProgress: _currentProgress,
                completed: _completed,
                total: _total,
              ),
              const SizedBox(height: ZzzSpacing.md),
              ZzzTextField(label: 'Tags (comma separated)', controller: _tags),
              const SizedBox(height: ZzzSpacing.md),
              ZzzTextField(
                label: 'Image URL (optional)',
                controller: _imageUrl,
                keyboardType: TextInputType.url,
                validator: GameFormValidators.imageUrl,
              ),
              const SizedBox(height: ZzzSpacing.xl),
              ZzzButton(label: 'Save game', onPressed: _save),
            ],
          ),
        ),
      ),
    );
  }
}
