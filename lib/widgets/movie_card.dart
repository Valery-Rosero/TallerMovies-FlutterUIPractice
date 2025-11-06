import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../services/api_config.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;
  final double width;
  final double height;
  final bool showTitleOverlay;
  const MovieCard({
    super.key,
    required this.movie,
    required this.onTap,
    this.width = 180,
    this.height = 280,
    this.showTitleOverlay = true,
  });

  @override
  Widget build(BuildContext context) {
    final posterUrl = ApiConfig.posterUrl(movie.posterPath);
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: 'poster_${movie.id}',
        child: Card(
          elevation: 6,
          margin: EdgeInsets.zero,
          shadowColor: Colors.black.withOpacity(0.12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: SizedBox(
              width: width,
              height: height,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  posterUrl.isEmpty
                      ? Container(
                          color: Colors.grey.shade300,
                          child: Center(
                              child: Text(
                            movie.title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium,
                          )),
                        )
                      : CachedNetworkImage(
                          imageUrl: posterUrl,
                          fit: BoxFit.cover,
                        ),
                  if (showTitleOverlay)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Color(0xAA000000), Colors.transparent],
                          ),
                        ),
                        child: Text(
                          movie.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}