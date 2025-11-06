import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../services/api_config.dart';

class CastAvatar extends StatelessWidget {
  final Person person;
  const CastAvatar({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    final url = ApiConfig.profileUrl(person.profilePath);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(
            child: url.isEmpty
                ? const SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(Icons.person, size: 32),
                  )
                : CachedNetworkImage(
                    imageUrl: url,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => const Icon(Icons.person, size: 32),
                  ),
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 80,
          child: Text(
            person.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}