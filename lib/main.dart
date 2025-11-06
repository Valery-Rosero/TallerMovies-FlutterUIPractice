import 'package:flutter/material.dart';

import 'screens/explore_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      theme: AppTheme.light(),
      debugShowCheckedModeBanner: false,
      home: const ExploreScreen(),
    );
  }
}
