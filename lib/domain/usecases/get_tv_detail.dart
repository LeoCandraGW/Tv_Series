import 'package:dartz/dartz.dart';
import 'package:TV_Series/domain/entities/tv_detail.dart';
import 'package:TV_Series/domain/repositories/tv_repository.dart';
import 'package:TV_Series/common/failure.dart';

class GetTvDetail {
  final TvRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
