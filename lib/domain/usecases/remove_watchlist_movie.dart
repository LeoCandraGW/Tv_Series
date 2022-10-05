import 'package:dartz/dartz.dart';
import 'package:TV_Series/common/failure.dart';
import 'package:TV_Series/domain/entities/movie_detail.dart';
import 'package:TV_Series/domain/repositories/movie_repository.dart';

class RemoveWatchlist {
  final MovieRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
