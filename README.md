# Movies App (Flutter)

A modern Material 3 Flutter app that explores trending movies and detailed information using live data from The Movie Database (TMDb).

## Features
- Explore screen with search, date chips, and movie grid
- Movie details with poster hero, rating badge, year, runtime, genres, director, overview, and cast
- Cached images, smooth animations, and Google Fonts typography

## Setup
1. Install dependencies:
   - `flutter pub get`
2. Provide a TMDb API key via Dart define when running:
   - Web (Chrome): `flutter run -d chrome --dart-define=TMDB_API_KEY=YOUR_KEY`
   - Windows desktop: `flutter run -d windows --dart-define=TMDB_API_KEY=YOUR_KEY`

You can obtain a free key by creating an account at https://www.themoviedb.org/.

## Project Structure
```
lib/
  screens/
  widgets/
  models/
  services/
  theme/
```

## Notes
- If the key is not provided, the app still runs and shows a hint to supply `TMDB_API_KEY`.
- Images come from TMDb (`image.tmdb.org`) with caching for performance.
