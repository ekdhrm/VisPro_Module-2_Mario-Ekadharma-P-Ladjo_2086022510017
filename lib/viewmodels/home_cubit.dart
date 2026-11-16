import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/domain/game.dart';
import '../models/domain/game_repository.dart';
import 'home_state.dart';

/// Owns the home screen's business state. The view only reads it.
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository) : super(const HomeLoading());

  final GameRepository _repository;

  /// Reads saved games and always ends in a visible state.
  Future<void> load() async {
    if (isClosed) return;
    emit(const HomeLoading());
    try {
      final games = await _repository.getGames();
      if (isClosed) return;
      emit(HomeLoaded(games));
    } catch (_) {
      if (isClosed) return;
      emit(
        const HomeFailure(
          'Your games could not be loaded. Check your storage and try again.',
        ),
      );
    }
  }

  /// Saves first, then shows the game. Returns false if saving failed.
  Future<bool> addGame(GameProgress game) async {
    final current = state;
    if (current is! HomeLoaded) return false;
    try {
      await _repository.addGame(game);
      if (isClosed) return false;
      emit(current.copyWith(games: [...current.games, game]));
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Reloads without the loading state. Used after detail edits.
  Future<void> refresh() async {
    try {
      final games = await _repository.getGames();
      if (isClosed) return;
      final current = state;
      emit(
        current is HomeLoaded
            ? current.copyWith(games: games)
            : HomeLoaded(games),
      );
    } catch (_) {
      // Keep the current state; the detail screen reported its own errors.
    }
  }

  void setQuery(String query) {
    final current = state;
    if (current is! HomeLoaded || current.query == query) return;
    emit(current.copyWith(query: query));
  }
}
