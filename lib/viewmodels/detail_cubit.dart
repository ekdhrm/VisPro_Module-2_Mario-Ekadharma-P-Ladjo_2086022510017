import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/domain/game.dart';
import '../models/domain/game_repository.dart';
import 'detail_state.dart';

/// Holds one game while the detail screen edits its tasks or progress.
class DetailCubit extends Cubit<DetailState> {
  DetailCubit(this._repository, GameProgress game) : super(DetailReady(game));

  final GameRepository _repository;

  /// Flips one task, then saves the whole game.
  Future<void> toggleTask(int index) async {
    final game = state.game;
    if (index < 0 || index >= game.tasks.length) return;
    final tasks = [...game.tasks];
    tasks[index] = tasks[index].copyWith(
      isCompleted: !tasks[index].isCompleted,
    );
    await _save(game.copyWith(tasks: tasks));
  }

  /// Adds a task, then saves the whole game.
  Future<void> addTask(TodoItem task) async {
    final game = state.game;
    await _save(game.copyWith(tasks: [...game.tasks, task]));
  }

  /// Saves a game returned by the progress form.
  Future<void> updateProgress(GameProgress updated) async {
    if (updated.id != state.game.id) return;
    await _save(updated);
  }

  Future<void> _save(GameProgress updated) async {
    if (state is DetailSaving) return;
    final previous = state.game;
    emit(DetailSaving(previous));
    try {
      await _repository.updateGame(updated);
      if (isClosed) return;
      emit(DetailReady(updated));
    } catch (_) {
      if (isClosed) return;
      emit(
        DetailFailure(
          previous,
          'The change could not be saved. Please try again.',
        ),
      );
    }
  }
}
