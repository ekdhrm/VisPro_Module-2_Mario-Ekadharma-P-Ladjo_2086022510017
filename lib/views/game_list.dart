import 'package:flutter/material.dart';

import '../core/theme/zzz_shapes.dart';
import '../models/domain/game.dart';
import 'game_card.dart';

/// Renders a single-column list on phones and a two-column grid on tablets.
class GameList extends StatelessWidget {
  const GameList({super.key, required this.games, required this.onGameTap});

  final List<GameProgress> games;
  final ValueChanged<GameProgress> onGameTap;

  static const double _tabletBreakpoint = 600;

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.crossAxisExtent >= _tabletBreakpoint;
        return SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            ZzzSpacing.md,
            0,
            ZzzSpacing.md,
            ZzzSpacing.xl,
          ),
          sliver: isTablet ? _grid() : _list(),
        );
      },
    );
  }

  Widget _list() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: ZzzSpacing.md),
          child: _card(index),
        ),
        childCount: games.length,
      ),
    );
  }

  Widget _grid() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: ZzzSizes.cardExtent,
        crossAxisSpacing: ZzzSpacing.md,
        mainAxisSpacing: ZzzSpacing.md,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => _card(index),
        childCount: games.length,
      ),
    );
  }

  Widget _card(int index) {
    final game = games[index];
    return GameCard(game: game, onTap: () => onGameTap(game));
  }
}
