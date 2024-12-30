class Movie {
  final String title;
  final String year;
  final String imdbID;
  final String poster;
  final String rating;

  Movie({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.poster,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      imdbID: json['imdbID'] ?? '',
      poster: json['Poster'] != 'N/A' ? json['Poster'] : 'images/placeholder.jpg',
      rating: json['imdbRating'] ?? 'N/A',
    );
  }
}