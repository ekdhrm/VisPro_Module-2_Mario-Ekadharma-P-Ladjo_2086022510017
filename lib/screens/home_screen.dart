import 'package:flutter/material.dart';
import '../model/game.dart';
import '../widgets/game_list.dart';
import '../widgets/game_search_field.dart';
import '../widgets/progress_header.dart';
import '../widgets/progress_summary.dart';
import 'add_screen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.games});

  final List<GameProgress> games;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<GameProgress> _allGames;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _allGames = List.from(widget.games);
  }

  List<GameProgress> get _visibleGames {
    if (_query.trim().isEmpty) return _allGames;
    final q = _query.toLowerCase().trim();
    return _allGames.where((g) => g.title.toLowerCase().contains(q)).toList();
  }

  int get _totalObjectives {
    return _visibleGames.fold(0, (total, g) => total + g.totalObjectives);
  }

  void _openGame(GameProgress game) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailScreen(game: game)),
    );
  }

  Future<void> _addNewGame() async {
    final result = await Navigator.push<GameProgress>(
      context,
      MaterialPageRoute(builder: (context) => const AddScreen()),
    );
    if (result != null) {
      setState(() => _allGames.add(result));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visibleGames;

    return Scaffold(
      appBar: AppBar(title: const Text('Game Progress')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 600;

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ProgressHeader(),
                        const SizedBox(height: 20),
                        GameSearchField(
                          controller: _searchController,
                          onChanged: (val) => setState(() => _query = val),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'My Games',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
                if (visible.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.videogame_asset_off,
                            size: 64,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No games found.',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (_query.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            FilledButton.tonal(
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _query = '');
                              },
                              child: const Text('Reset Search'),
                            ),
                          ],
                        ],
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: GameList(
                      games: visible,
                      onGameTap: _openGame,
                      isTablet: isTablet,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewGame,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ProgressSummary(
            gameCount: visible.length,
            objectiveCount: _totalObjectives,
          ),
        ),
      ),
    );
  }
}