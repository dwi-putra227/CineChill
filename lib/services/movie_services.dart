import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_mcc_lec/model/movie.dart';

class OmdbService {
  final String apiKey = '';
  final String baseUrl = 'https://www.omdbapi.com/';
  final Map<String, List<Movie>> _cache = {};

  Future<List<Movie>> searchMovies(String query) async {
    // Check cache first
    if (_cache.containsKey(query)) {
      return _cache[query]!;
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl?apikey=$apiKey&s=$query&type=movie&page=1&r=json&v=1'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['Response'] == 'True') {
          List<dynamic> results = data['Search'];

          // Parallel requests for movie details
          final movies = await Future.wait(
            results.map((movie) async {
              final details = await getMovieDetails(movie['imdbID']);
              movie['imdbRating'] = details['imdbRating'];
              return Movie.fromJson(movie);
            }),
          );

          // Store in cache
          _cache[query] = movies;
          return movies;
        } else {
          throw Exception(data['Error']);
        }
      } else {
        throw Exception('Failed to search movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> getMovieDetails(String imdbId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?apikey=$apiKey&i=$imdbId'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get movie details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}