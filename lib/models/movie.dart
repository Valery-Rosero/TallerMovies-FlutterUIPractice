class Movie {
  final int id;
  final String title;
  final String? posterPath;
  final String? backdropPath;
  final String? overview;
  final String? releaseDate;
  final double voteAverage;

  Movie({
    required this.id,
    required this.title,
    this.posterPath,
    this.backdropPath,
    this.overview,
    this.releaseDate,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? json['name'] ?? '',
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
    );
  }

  String get year => (releaseDate != null && releaseDate!.isNotEmpty)
      ? DateTime.tryParse(releaseDate!)?.year.toString() ?? ''
      : '';
}

class Genre {
  final int id;
  final String name;
  Genre({required this.id, required this.name});
  factory Genre.fromJson(Map<String, dynamic> json) =>
      Genre(id: json['id'], name: json['name']);
}

class Person {
  final int id;
  final String name;
  final String? profilePath;
  final String? job;
  Person({required this.id, required this.name, this.profilePath, this.job});
  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json['id'],
        name: json['name'] ?? '',
        profilePath: json['profile_path'],
        job: json['job'],
      );
}

class MovieDetails {
  final Movie movie;
  final int? runtime;
  final List<Genre> genres;
  final List<Person> cast;
  final List<Person> crew;
  MovieDetails({
    required this.movie,
    this.runtime,
    required this.genres,
    required this.cast,
    required this.crew,
  });
}