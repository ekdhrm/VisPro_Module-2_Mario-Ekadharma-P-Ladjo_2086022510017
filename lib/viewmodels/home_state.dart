import 'package:equatable/equatable.dart';

import '../models/domain/game.dart';

/// Every state the home screen can render.
sealed class HomeState extends Equatable {
  const HomeState();

  int get gameCount => 0;

  int get objectiveCount => 0;

  @override
  List<Object?> get props => const [];
}

/// Saved games are being read.
final class HomeLoading extends HomeState {
  const HomeLoading();
}

/// The read failed. [message] is already written for the user.
final class HomeFailure extends HomeState {
  const HomeFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Games were read successfully. [query] filters them on screen.
final class HomeLoaded extends HomeState {
  const HomeLoaded(this.games, {this.query = ''});

  final List<GameProgress> games;
  final String query;

  List<GameProgress> get visibleGames {
    final search = query.trim().toLowerCase();
    if (search.isEmpty) return games;
    return games
        .where((game) => game.title.toLowerCase().contains(search))
        .toList(growable: false);
  }

  @override
  int get gameCount => visibleGames.length;

  @override
  int get objectiveCount =>
      visibleGames.fold(0, (total, game) => total + game.totalObjectives);

  HomeLoaded copyWith({List<GameProgress>? games, String? query}) {
    return HomeLoaded(games ?? this.games, query: query ?? this.query);
  }

  @override
  List<Object?> get props => [games, query];
}
