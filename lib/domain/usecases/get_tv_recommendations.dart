import 'package:dartz/dartz.dart';
import 'package:TV_Series/domain/entities/tv.dart';
import 'package:TV_Series/domain/repositories/tv_repository.dart';
import 'package:TV_Series/common/failure.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
