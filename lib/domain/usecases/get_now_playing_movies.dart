import 'package:dartz/dartz.dart';
import 'package:TV_Series/domain/entities/movie.dart';
import 'package:TV_Series/domain/repositories/movie_repository.dart';
import 'package:TV_Series/common/failure.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
