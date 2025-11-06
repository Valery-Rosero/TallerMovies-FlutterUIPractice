import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../services/api_config.dart';
import '../services/tmdb_api.dart';
import '../widgets/cast_avatar.dart';
import '../widgets/category_tags.dart';
import '../widgets/rating_badge.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  final Movie? initialMovie;
  const MovieDetailsScreen({super.key, required this.movieId, this.initialMovie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final api = TmdbApi();
  MovieDetails? details;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final d = await api.movieDetails(widget.movieId);
    if (!mounted) return;
    setState(() => details = d);
  }

  @override
  Widget build(BuildContext context) {
    final movie = details?.movie ?? widget.initialMovie;
    final genres = details?.genres ?? [];
    final cast = details?.cast ?? [];
    final director = api.directorName(details?.crew ?? []);
    final posterUrl = ApiConfig.posterUrl(movie?.posterPath);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 320,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'poster_${widget.movieId}',
                    child: posterUrl.isEmpty
                        ? Container(color: Colors.grey.shade300)
                        : CachedNetworkImage(imageUrl: posterUrl, fit: BoxFit.cover),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Color(0xAA000000), Colors.transparent],
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(movie?.title ?? 'Details'),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie?.title ?? '',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: 6),
                                  StarRating(rating: movie?.voteAverage ?? 0),
                                ],
                              ),
                            ),
                            const ImdbBadge(),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: _InfoChip(label: 'Year', value: movie?.year ?? '--'),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: _InfoChip(
                                  label: 'Type',
                                  value: genres.isNotEmpty ? genres.first.name : '--',
                                  highlight: true,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: _InfoChip(
                                  label: 'Hour',
                                  value: details?.runtime != null
                                      ? '${(details!.runtime! ~/ 60)}h ${(details!.runtime! % 60)}min'
                                      : '--',
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: _InfoChip(label: 'Director', value: director ?? '--'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        CategoryTags(tags: genres.map((g) => g.name).toList()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Plot Summary', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(
                    movie?.overview ?? 'No overview available.',
                    style: const TextStyle(color: Colors.black54, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  Text('Cast', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: cast.take(10).length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) => CastAvatar(person: cast[index]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;
  const _InfoChip({required this.label, required this.value, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: highlight ? Colors.grey.shade200.withOpacity(0.7) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}