import 'package:flutter/material.dart';

class RatingBadge extends StatelessWidget {
  final double rating; // TMDb 0-10
  const RatingBadge({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, color: Colors.amber.shade600, size: 18),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class ImdbBadge extends StatelessWidget {
  const ImdbBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD000),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: const Text(
        'IMDb',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating; // 0-10
  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    // Normalizamos a 0-5
    final value = (rating / 2).clamp(0, 5);
    final full = value.floor();
    final hasHalf = (value - full) >= 0.5;
    final total = 5;
    final stars = <Widget>[];
    for (var i = 0; i < total; i++) {
      IconData icon;
      if (i < full) {
        icon = Icons.star_rounded;
      } else if (i == full && hasHalf) {
        icon = Icons.star_half_rounded;
      } else {
        icon = Icons.star_outline_rounded;
      }
      stars.add(Icon(icon, color: Colors.amber.shade600, size: 16));
    }
    return Row(children: stars);
  }
}