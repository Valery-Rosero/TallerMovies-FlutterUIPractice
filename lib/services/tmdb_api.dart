import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/movie.dart';
import 'api_config.dart';
import 'mock_data.dart';

class TmdbApi {
  final String _apiKey = ApiConfig.apiKey; // v3 key
  final String _bearer = const String.fromEnvironment('TMDB_BEARER_TOKEN'); // optional v4 token

  bool get hasKey => _apiKey.isNotEmpty || _bearer.isNotEmpty;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json;charset=utf-8',
        if (_bearer.isNotEmpty) 'Authorization': 'Bearer $_bearer',
      };

  Uri _uri(String path, [Map<String, String>? params]) {
    final merged = {
      // Use v3 api_key only when Bearer is not provided
      if (_bearer.isEmpty && _apiKey.isNotEmpty) 'api_key': _apiKey,
      'language': 'en-US',
      ...?params,
    };
    return Uri.parse('${ApiConfig.baseUrl}$path').replace(queryParameters: merged);
  }

  Future<List<Movie>> trendingMovies() async {
    if (!hasKey) {
      // Fallback to mock when no API key/token is provided
      return MockData.trendingMovies();
    }
    final resp = await http.get(_uri('/trending/movie/week'), headers: _headers);
    if (resp.statusCode != 200) return [];
    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    final results = (data['results'] as List).cast<Map<String, dynamic>>();
    return results.map(Movie.fromJson).toList();
  }

  Future<MovieDetails?> movieDetails(int id) async {
    if (!hasKey) {
      // Fallback to local mock details when no API key/token is provided
      return MockData.details(id);
    }
    final detailsResp = await http.get(_uri('/movie/$id'), headers: _headers);
    final creditsResp = await http.get(_uri('/movie/$id/credits'), headers: _headers);
    if (detailsResp.statusCode != 200 || creditsResp.statusCode != 200) return null;
    final detailsJson = jsonDecode(detailsResp.body) as Map<String, dynamic>;
    final movie = Movie.fromJson(detailsJson);
    final genres = (detailsJson['genres'] as List?)
            ?.map((e) => Genre.fromJson(e))
            .toList() ??
        [];
    final creditsJson = jsonDecode(creditsResp.body) as Map<String, dynamic>;
    final cast = (creditsJson['cast'] as List?)
            ?.map((e) => Person.fromJson(e))
            .toList() ??
        [];
    final crew = (creditsJson['crew'] as List?)
            ?.map((e) => Person.fromJson(e))
            .toList() ??
        [];
    return MovieDetails(movie: movie, runtime: detailsJson['runtime'], genres: genres, cast: cast, crew: crew);
  }

  Future<List<Map<String, dynamic>>> videos(int id) async {
    final resp = await http.get(_uri('/movie/$id/videos'), headers: _headers);
    if (resp.statusCode != 200) return [];
    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    return (data['results'] as List).cast<Map<String, dynamic>>();
  }

  String? directorName(List<Person> crew) {
    try {
      return crew.firstWhere((p) => p.job == 'Director').name;
    } catch (_) {
      return null;
    }
  }
}