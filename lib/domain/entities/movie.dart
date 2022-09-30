import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  Movie({
        required this.backdropPath,
        required this.genreIds,
        required this.id,
        required this.name,
        required this.originalName,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.voteAverage,
        required this.voteCount,
  });

  Movie.watchlisto({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

    String? backdropPath;
    List<int>? genreIds;
    int id;
    String? name;
    List<String>? originCountry;
    String? originalLanguage;
    String? originalName;
    String? overview;
    double? popularity;
    String? posterPath;
    double? voteAverage;
    int? voteCount;

  @override
  List<Object?> get props => [
        genreIds,
        id,
        name,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
