import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/theme/zzz_shapes.dart';
import '../core/widgets/zzz_stripe_background.dart';
import '../models/domain/game.dart';
import '../models/domain/game_repository.dart';
import '../viewmodels/home_cubit.dart';
import '../viewmodels/home_state.dart';
import 'add_game_view.dart';
import 'detail_view.dart';
import 'home_body.dart';
import 'progress_summary.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.repository});

  final GameRepository repository;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  late final HomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = HomeCubit(widget.repository)..load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _cubit.close();
    super.dispose();
  }

  Future<void> _openGame(GameProgress game) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => DetailView(game: game, repository: widget.repository),
      ),
    );
    await _cubit.refresh();
  }

  Future<void> _addGame() async {
    final game = await Navigator.push<GameProgress>(
      context,
      MaterialPageRoute<GameProgress>(builder: (_) => const AddGameView()),
    );
    if (game == null) return;
    final saved = await _cubit.addGame(game);
    if (!saved && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('The game could not be saved. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _cubit,
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: ZzzStripeBackground(
              child: HomeBody(
                state: state,
                searchController: _searchController,
                onSearchChanged: _cubit.setQuery,
                onGameTap: _openGame,
                onRetry: _cubit.load,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _addGame,
            tooltip: 'Add game',
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(ZzzSpacing.md),
              child: ProgressSummary(
                gameCount: state.gameCount,
                objectiveCount: state.objectiveCount,
              ),
            ),
          ),
        );
      },
    );
  }
}
