import 'package:flutter/material.dart';
import '../model/game.dart';
import 'game_card.dart';

class GameList extends StatelessWidget {
  const GameList({
    super.key,
    required this.games,
    required this.onGameTap,
    this.isTablet = false,
  });

  final List<GameProgress> games;
  final ValueChanged<GameProgress> onGameTap;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    if (isTablet) {
      return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.8,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => GameCard(
            game: games[index],
            onTap: () => onGameTap(games[index]),
          ),
          childCount: games.length,
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => GameCard(
          game: games[index],
          onTap: () => onGameTap(games[index]),
        ),
        childCount: games.length,
      ),
    );
  }
}