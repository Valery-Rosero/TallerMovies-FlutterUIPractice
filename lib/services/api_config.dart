class ApiConfig {
  // Provide TMDb key via --dart-define=TMDB_API_KEY=your_key
  static const String apiKey = String.fromEnvironment('TMDB_API_KEY');
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBase = 'https://image.tmdb.org/t/p';

  static String posterUrl(String? path, {String size = 'w500'}) {
    if (path == null || path.isEmpty) return '';
    if (path.startsWith('http')) return path;
    return '$imageBase/$size$path';
  }

  static String profileUrl(String? path, {String size = 'w185'}) {
    if (path == null || path.isEmpty) return '';
    if (path.startsWith('http')) return path;
    return '$imageBase/$size$path';
  }
}