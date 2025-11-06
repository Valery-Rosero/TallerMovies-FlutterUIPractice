import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light() {
    // Colors inspired by the reference: soft pink background, deep blue titles,
    // vibrant pink selection accents.
    final seed = const Color.fromARGB(255, 255, 255, 255);
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ).copyWith(
          primary: const Color(0xFF1E3A8A), // deep blue for titles
          secondary: const Color(0xFFFF4D6D), // selection accent
          surface: Colors.white,
        );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      textTheme: GoogleFonts.poppinsTextTheme(),
      scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      cardTheme: const CardThemeData(
        elevation: 6,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: Colors.white,
        selectedColor: Color(0xFFFF4D6D),
        labelStyle: TextStyle(color: Colors.black),
        secondaryLabelStyle: TextStyle(color: Colors.white),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: StadiumBorder(),
        elevation: 4,
        pressElevation: 0,
      ),
    );
  }

  static BoxDecoration softBackground() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 255, 255, 255),
        ],
      ),
    );
  }
}
