class Movie {
  final int id;
  final String title;
  final String director;
  final int releaseYear;
  final double rating;

  Movie(
      {required this.id,
      required this.title,
      required this.director,
      required this.releaseYear,
      required this.rating});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'director': director,
      'releaseYear': releaseYear,
      'rating': rating,
    };
  }
}
