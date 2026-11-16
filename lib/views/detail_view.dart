import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/domain/game.dart';
import '../models/domain/game_repository.dart';
import '../viewmodels/detail_cubit.dart';
import '../viewmodels/detail_state.dart';
import 'add_task_view.dart';
import 'detail_content.dart';
import 'update_progress_view.dart';

/// Detail page. Edits are saved through [DetailCubit].
class DetailView extends StatefulWidget {
  const DetailView({super.key, required this.game, required this.repository});

  final GameProgress game;
  final GameRepository repository;

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late final DetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = DetailCubit(widget.repository, widget.game);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Future<void> _toggleTask(int index) => _cubit.toggleTask(index);

  Future<void> _addTask() async {
    final task = await Navigator.push<TodoItem>(
      context,
      MaterialPageRoute<TodoItem>(builder: (_) => const AddTaskView()),
    );
    if (task == null || !mounted) return;
    await _cubit.addTask(task);
  }

  Future<void> _editProgress() async {
    final updated = await Navigator.push<GameProgress>(
      context,
      MaterialPageRoute<GameProgress>(
        builder: (_) => UpdateProgressView(game: _cubit.state.game),
      ),
    );
    if (updated == null || !mounted) return;
    await _cubit.updateProgress(updated);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailCubit, DetailState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state is DetailFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: DetailContent(
            game: state.game,
            onToggleTask: _toggleTask,
            onAddTask: _addTask,
            onEditProgress: _editProgress,
          ),
        );
      },
    );
  }
}
