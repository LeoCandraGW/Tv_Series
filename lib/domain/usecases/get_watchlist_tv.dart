import 'package:dartz/dartz.dart';
import 'package:TV_Series/domain/entities/tv.dart';
import 'package:TV_Series/domain/repositories/tv_repository.dart';
import 'package:TV_Series/common/failure.dart';

class GetWatchlistTv {
  final TvRepository _repository;

  GetWatchlistTv(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchlistTv();
  }
}
