import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/movie.dart';
import '../services/tmdb_api.dart';
import '../theme/app_theme.dart';
import '../widgets/date_selector.dart';
import '../widgets/movie_card.dart';
import '../widgets/search_bar.dart';
import 'movie_details_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final api = TmdbApi();
  late Future<List<Movie>> _future;
  int _selectedDay = 1; // preselect like the design
  String _query = '';
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _future = api.trendingMovies();
    _pageController = PageController(viewportFraction: 0.74);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.softBackground(),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSearchBar(onSubmitted: (v) {
                        setState(() => _query = v.trim());
                      }),
                      const SizedBox(height: 16),
                      Text('Explore', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black87)),
                      Text('Top Movies', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.primary)),
                      const SizedBox(height: 12),
                      DateSelector(
                        start: DateTime.now(),
                        selectedIndex: _selectedDay,
                        onChanged: (i) => setState(() => _selectedDay = i),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder<List<Movie>>(
                future: _future,
                builder: (context, snapshot) {
                  final movies = snapshot.data ?? [];
                  final filtered = _query.isEmpty
                      ? movies
                      : movies.where((m) => m.title.toLowerCase().contains(_query.toLowerCase())).toList();
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (movies.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          api.hasKey
                              ? 'No movies available right now.'
                              : 'Provide TMDB_API_KEY via --dart-define to load live data.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  final screenWidth = MediaQuery.of(context).size.width;
                  final itemWidth = screenWidth * 0.74;
                  final itemHeight = itemWidth * 1.5; // ~2:3 proporción
                  return SliverToBoxAdapter(
                    child: SizedBox(
                      height: itemHeight + 24,
                      child: PageView.builder(
                        controller: _pageController,
                        padEnds: true,
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final movie = filtered[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            child: MovieCard(
                              movie: movie,
                              width: itemWidth,
                              height: itemHeight,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => MovieDetailsScreen(movieId: movie.id, initialMovie: movie),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 8),
                      Text('Trailers'),
                      SizedBox(height: 8),
                      _TrailerPlaceholderList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TrailerPlaceholderList extends StatelessWidget {
  const _TrailerPlaceholderList();
  @override
  Widget build(BuildContext context) {
    final thumbs = const [
      'https://picsum.photos/id/1011/320/180',
      'https://picsum.photos/id/1015/320/180',
      'https://picsum.photos/id/1025/320/180',
      'https://picsum.photos/id/1035/320/180',
      'https://picsum.photos/id/1043/320/180',
    ];
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: thumbs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) => ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: thumbs[i],
                width: 160,
                height: 110,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.25), Colors.transparent],
                    ),
                  ),
                ),
              ),
              const Positioned.fill(
                child: Center(
                  child: Icon(
                    Icons.play_circle_fill,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}