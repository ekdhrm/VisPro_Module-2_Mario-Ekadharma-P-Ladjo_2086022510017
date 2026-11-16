import 'package:equatable/equatable.dart';

import '../models/domain/game.dart';

/// Every state the detail screen can render.
sealed class DetailState extends Equatable {
  const DetailState(this.game);

  final GameProgress game;
}

/// Nothing is being saved; the actions are available.
final class DetailReady extends DetailState {
  const DetailReady(super.game);

  @override
  List<Object?> get props => [game];
}

/// A save is in flight. The content stays visible.
final class DetailSaving extends DetailState {
  const DetailSaving(super.game);

  @override
  List<Object?> get props => [game];
}

/// A save failed. The listener shows [message] and keeps the old game.
final class DetailFailure extends DetailState {
  const DetailFailure(super.game, this.message);

  final String message;

  @override
  List<Object?> get props => [game, message];
}
