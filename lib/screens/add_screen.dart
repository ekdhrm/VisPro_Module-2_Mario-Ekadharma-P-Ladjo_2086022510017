import 'package:flutter/material.dart';
import '../model/game.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _currentProgress = '';
  int _completedObjectives = 0;
  int _totalObjectives = 10;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newGame = GameProgress(
        title: _title,
        currentProgress: _currentProgress,
        completedObjectives: _completedObjectives,
        totalObjectives: _totalObjectives,
      );
      Navigator.pop(context, newGame);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Game Progress')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Game Title'),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Enter a title' : null,
                onSaved: (val) => _title = val!.trim(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Current Progress (e.g. Chapter 3)'),
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Enter current progress'
                    : null,
                onSaved: (val) => _currentProgress = val!.trim(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Completed Objectives'),
                keyboardType: TextInputType.number,
                initialValue: '0',
                validator: (val) =>
                    val == null || int.tryParse(val) == null ? 'Enter a number' : null,
                onSaved: (val) => _completedObjectives = int.parse(val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Total Objectives'),
                keyboardType: TextInputType.number,
                initialValue: '10',
                validator: (val) =>
                    val == null || int.tryParse(val) == null ? 'Enter a number' : null,
                onSaved: (val) => _totalObjectives = int.parse(val!),
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: _submit,
                child: const Text('Save Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}