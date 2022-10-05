import 'package:dartz/dartz.dart';
import 'package:TV_Series/common/failure.dart';
import 'package:TV_Series/domain/entities/movie.dart';
import 'package:TV_Series/domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
