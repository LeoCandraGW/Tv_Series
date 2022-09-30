import 'package:dartz/dartz.dart';
import 'package:TV_Series/common/failure.dart';
import 'package:TV_Series/domain/entities/movie.dart';
import 'package:TV_Series/domain/repositories/movie_repository.dart';

class GetPopularMovies {
  final MovieRepository repository;

  GetPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getPopularMovies();
  }
}
