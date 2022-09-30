import 'package:TV_Series/domain/entities/movie.dart';
import 'package:TV_Series/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

class MovieTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  MovieTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
        id: movie.id,
        name: movie.name,
        posterPath: movie.posterPath,
        overview: movie.overview,
      );

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  Movie toEntity() => Movie.watchlisto(
        id: id,
        overview: overview.toString(),
        posterPath: posterPath.toString(),
        name: name.toString(),
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, posterPath, overview];
}
