import 'package:flutter/material.dart';

import '../core/theme/zzz_shapes.dart';
import '../models/domain/game.dart';
import '../viewmodels/home_state.dart';
import 'game_list.dart';
import 'home_intro.dart';
import 'home_status.dart';

/// Scrollable body of the home screen. It renders every [HomeState].
class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.state,
    required this.searchController,
    required this.onSearchChanged,
    required this.onGameTap,
    required this.onRetry,
  });

  final HomeState state;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<GameProgress> onGameTap;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final current = state;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(ZzzSpacing.md),
            child: HomeIntro(
              searchController: searchController,
              onSearchChanged: onSearchChanged,
            ),
          ),
        ),
        if (current is HomeLoaded && current.visibleGames.isNotEmpty)
          GameList(games: current.visibleGames, onGameTap: onGameTap)
        else
          SliverFillRemaining(hasScrollBody: false, child: _status()),
      ],
    );
  }

  Widget _status() {
    return switch (state) {
      HomeLoading() => const Center(child: CircularProgressIndicator()),
      HomeFailure(:final message) => HomeStatus(
        message: message,
        icon: Icons.cloud_off,
        actionLabel: 'Retry',
        onAction: onRetry,
      ),
      HomeLoaded(:final query) when query.trim().isNotEmpty => HomeStatus(
        message: 'No games match "$query".',
        icon: Icons.videogame_asset_off,
        actionLabel: 'Clear search',
        onAction: _clearSearch,
      ),
      HomeLoaded() => const HomeStatus(
        message: 'No games yet. Tap + to add your first game.',
        icon: Icons.videogame_asset_off,
      ),
    };
  }

  void _clearSearch() {
    searchController.clear();
    onSearchChanged('');
  }
}
