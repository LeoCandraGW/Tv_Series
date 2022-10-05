import 'package:dartz/dartz.dart';
import 'package:TV_Series/domain/entities/movie.dart';
import 'package:TV_Series/domain/repositories/movie_repository.dart';
import 'package:TV_Series/common/failure.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
