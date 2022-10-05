import 'package:dartz/dartz.dart';
import 'package:TV_Series/domain/entities/movie_detail.dart';
import 'package:TV_Series/domain/repositories/movie_repository.dart';
import 'package:TV_Series/common/failure.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
