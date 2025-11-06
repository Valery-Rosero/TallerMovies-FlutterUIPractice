import '../models/movie.dart';

/// Mock data con películas reales, portadas oficiales y fotos de cast válidas.
class MockData {
  static List<Movie> trendingMovies() {
    const sample = [
      {
        'id': 1,
        'title': 'Oppenheimer',
        'poster_path':
            'https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg',
        'backdrop_path':
            'https://image.tmdb.org/t/p/w780/2E1b8yFihmFzqnl3V4I8dn1V1ZC.jpg',
        'overview':
            'The story of J. Robert Oppenheimer and his role in the development of the atomic bomb.',
        'release_date': '2023-07-21',
        'vote_average': 8.3,
      },
      {
        'id': 2,
        'title': 'Barbie',
        'poster_path':
            'https://image.tmdb.org/t/p/w500/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg',
        'backdrop_path':
            'https://image.tmdb.org/t/p/w780/nHf61UzkfFno5X1ofIhugCPus2R.jpg',
        'overview':
            'Barbie suffers a crisis that leads her to question her world and her existence.',
        'release_date': '2023-07-21',
        'vote_average': 7.4,
      },
      {
        'id': 3,
        'title': 'Her',
        'poster_path':
            'https://image.tmdb.org/t/p/w500/eCOtqtfvn7mxGl6nfmq4b1exJRc.jpg',
        'backdrop_path':
            'https://image.tmdb.org/t/p/w780/5A2bMlLfJrAfX9bqAibOL2gCruF.jpg',
        'overview':
            'In a near future, a lonely writer develops an unlikely relationship with an operating system.',
        'release_date': '2013-12-18',
        'vote_average': 8.0,
      },
      {
        'id': 4,
        'title': 'Dune: Part Two',
        'poster_path':
            'https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg',
        'backdrop_path':
            'https://image.tmdb.org/t/p/w780/1XDDXPXGiI8id7MrUxK36ke7gkX.jpg',
        'overview':
            'Paul Atreides unites with the Fremen and plots revenge against those who destroyed his family.',
        'release_date': '2024-03-01',
        'vote_average': 8.6,
      },
      {
        'id': 5,
        'title': 'The Batman',
        'poster_path':
            'https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg',
        'backdrop_path':
            'https://image.tmdb.org/t/p/w780/xHrp2pq73oi9D64xigPjWW1wcz1.jpg',
        'overview':
            'When the Riddler begins murdering political figures in Gotham, Batman must investigate the corruption.',
        'release_date': '2022-03-04',
        'vote_average': 7.8,
      },
      {
        'id': 6,
        'title': 'Spider-Man: Across the Spider-Verse',
        'poster_path':
            'https://image.tmdb.org/t/p/w500/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg',
        'backdrop_path':
            'https://image.tmdb.org/t/p/w780/14F6gMaRjzgsN2xLkzE2KE2wG5r.jpg',
        'overview':
            'Miles Morales embarks on a new adventure across the multiverse with a new team of Spider-People.',
        'release_date': '2023-06-02',
        'vote_average': 8.4,
      },
    ];
    return sample.map((e) => Movie.fromJson(e)).toList();
  }

  /// Mocked detailed info for each movie including valid actor profile URLs
  static MovieDetails details(int id) {
    final movie = trendingMovies().firstWhere(
      (m) => m.id == id,
      orElse: () => trendingMovies().first,
    );

    switch (movie.id) {
      case 1:
        return MovieDetails(
          movie: movie,
          runtime: 180,
          genres: [
            Genre(id: 18, name: 'Drama'),
            Genre(id: 36, name: 'History'),
          ],
          cast: [
            Person(
              id: 1,
              name: 'Cillian Murphy',
              profilePath:
                  'https://image.tmdb.org/t/p/w200/p9fZqHU6rTjZVv3I5GqRxyq5m7V.jpg',
            ),
            Person(
              id: 2,
              name: 'Emily Blunt',
              profilePath:
                  'https://image.tmdb.org/t/p/w200/1u7zR43vAyVd3j1C9rB1xP7zL9m.jpg',
            ),
            Person(
              id: 3,
              name: 'Robert Downey Jr.',
              profilePath:
                  'https://image.tmdb.org/t/p/w200/1YjdSym1jTG7xjHSI0yGGWEsw5i.jpg',
            ),
          ],
          crew: [Person(id: 11, name: 'Christopher Nolan', job: 'Director')],
        );
      case 2:
        return MovieDetails(
          movie: movie,
          runtime: 114,
          genres: [
            Genre(id: 35, name: 'Comedy'),
            Genre(id: 14, name: 'Fantasy'),
          ],
          cast: [
            Person(
              id: 4,
              name: 'Margot Robbie',
              profilePath:
                  'https://image.tmdb.org/t/p/w200/euDPyqLnuwaWMHajcU3oZ9uZezR.jpg',
            ),
            Person(
              id: 5,
              name: 'Ryan Gosling',
              profilePath:
                  'https://image.tmdb.org/t/p/w200/lyUyVARQKhGxaxy0FbPJCQRpiaW.jpg',
            ),
            Person(
              id: 6,
              name: 'America Ferrera',
              profilePath:
                  'https://image.tmdb.org/t/p/w200/vq4uFJrGBuEh6F1eJx7VpJ1kC6N.jpg',
            ),
          ],
          crew: [Person(id: 12, name: 'Greta Gerwig', job: 'Director')],
        );
      case 3:
        return MovieDetails(
          movie: movie,
          runtime: 126,
          genres: [
            Genre(id: 18, name: 'Drama'),
            Genre(id: 10749, name: 'Romance'),
          ],
          cast: [
            Person(
              id: 7,
              name: 'Joaquin Phoenix',
              profilePath:
                  'https://image.tmdb.org/t/p/w200/9Zb0yPgudvUdzQt9WZgXEAgi9Q3.jpg',
            ),
            Person(
              id: 8,
              name: 'Scarlett Johansson',
              profilePath:
                  'https://image.tmdb.org/t/p/w200/6NSxE7o2Qg8dYvjFBAi0bYgTGmj.jpg',
            ),
            Person(
              id: 9,
              name: 'Rooney Mara',
              profilePath:
                  'https://image.tmdb.org/t/p/w200/3Z96yZP6oEWm7bcC9R3a79mDy.jpg',
            ),
          ],
          crew: [Person(id: 12, name: 'Spike Jonze', job: 'Director')],
        );
      case 4:
        return MovieDetails(
          movie: movie,
          runtime: 166,
          genres: [
            Genre(id: 12, name: 'Adventure'),
            Genre(id: 878, name: 'Sci-Fi'),
          ],
          cast: [
            Person(
              id: 10,
              name: 'Timothée Chalamet',
              profilePath:
                  'https://image(tmdb).org/t/p/w200/nKGEpJ07BZV8sMRGHu8gK1w6v3z.jpg',
            ),
            Person(
              id: 11,
              name: 'Zendaya',
              profilePath:
                  'https://image.tmdb.org/t/p/w200/soK1K0THYgAfR2XfM8wXzQy3U0N.jpg',
            ),
            Person(
              id: 12,
              name: 'Rebecca Ferguson',
              profilePath:
                  'https://image.tmdb.org/t/p/w200/9izWm0n6Wz8GY0n4aT6K8aqkl8O.jpg',
            ),
          ],
          crew: [Person(id: 13, name: 'Denis Villeneuve', job: 'Director')],
        );
      case 5:
        return MovieDetails(
          movie: movie,
          runtime: 176,
          genres: [
            Genre(id: 80, name: 'Crime'),
            Genre(id: 9648, name: 'Mystery'),
          ],
          cast: [
            Person(
              id: 17,
              name: 'Robert Pattinson',
              profilePath:
                  'https://image.tmdb.org/t/p/w200/6heUu16fEC0ILnIa0tQOYv3lUjw.jpg',
            ),
            Person(
              id: 18,
              name: 'Zoë Kravitz',
              profilePath:
                  'https://image.tmdb.org/t/p/w200/eHdpDkK0bjK1bCyR1U4zgz7H2vE.jpg',
            ),
            Person(
              id: 19,
              name: 'Paul Dano',
              profilePath:
                  'https://image(tmdb).org/t/p/w200/d7fpL7eD6Y3xJmScPrLM4Wr7qJY.jpg',
            ),
          ],
          crew: [Person(id: 20, name: 'Matt Reeves', job: 'Director')],
        );
      case 6:
      default:
        return MovieDetails(
          movie: movie,
          runtime: 140,
          genres: [
            Genre(id: 16, name: 'Animation'),
            Genre(id: 28, name: 'Action'),
          ],
          cast: [
            Person(
              id: 21,
              name: 'Shameik Moore',
              profilePath:
                  'https://image(tmdb).org/t/p/w200/2fKQhO2fNcJ9oBYn7ET16lH7x4N.jpg',
            ),
            Person(
              id: 22,
              name: 'Hailee Steinfeld',
              profilePath:
                  'https://image.tmdb.org/t/p/w200/7K9lRZyRzR5PzqHfZ8vJrSwVb8S.jpg',
            ),
            Person(
              id: 23,
              name: 'Oscar Isaac',
              profilePath:
                  'https://image.tmdb.org/t/p/w200/a4I481szPqRzT2xpOsy8jvQqE9A.jpg',
            ),
          ],
          crew: [Person(id: 24, name: 'Joaquim Dos Santos', job: 'Director')],
        );
    }
  }
}
