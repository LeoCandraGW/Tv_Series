part of 'tv_bloc.dart';

abstract class TvEvent extends Equatable {
  const TvEvent();

  @override
  List<Object> get props => [];
}

class FetchNowplayingTv extends TvEvent {}

class FetchPopularTv extends TvEvent {}

class FetchTopRatedTv extends TvEvent {}

class FetchTvDetail extends TvEvent {
  final int id;
  const FetchTvDetail(this.id);

  @override
  List<Object> get props => [id];
}

class FetchTvRecommendation extends TvEvent {
  final int id;
  const FetchTvRecommendation(this.id);

  @override
  List<Object> get props => [id];
}

class FetchWatchListTv extends TvEvent {}

class SaveWatchlistTvs extends TvEvent {
  final TvDetail tv;

  const SaveWatchlistTvs(this.tv);
  @override
  List<Object> get props => [tv];
}

class RemoveWatchlistTvs extends TvEvent {
  final TvDetail tv;

  const RemoveWatchlistTvs(this.tv);
  @override
  List<Object> get props => [tv];
}

class LoadWatchlistTvStatus extends TvEvent {
  final int id;

  const LoadWatchlistTvStatus(this.id);

  @override
  List<Object> get props => [id];
}
