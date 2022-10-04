import 'package:dartz/dartz.dart';
import 'package:TV_Series/domain/entities/tv.dart';
import 'package:TV_Series/domain/repositories/tv_repository.dart';
import 'package:TV_Series/common/failure.dart';

class GetNowPlayingTv {
  final TvRepository repository;

  GetNowPlayingTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNowPlayingTv();
  }
}
