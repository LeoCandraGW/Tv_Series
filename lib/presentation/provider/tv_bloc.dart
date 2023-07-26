import 'package:bloc/bloc.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_now_playing_tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tv.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv.dart';
import 'package:tv_series/domain/usecases/get_tv_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_recommendations.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv.dart';
import 'package:tv_series/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv_series/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv_series/domain/usecases/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_bloc_event.dart';
part 'tv_bloc_state.dart';

class NowPlayingTvBloc extends Bloc<TvEvent, TvState> {
  final GetNowPlayingTv _getNowPlayingTv;
  NowPlayingTvBloc(this._getNowPlayingTv) : super(TvLoading()) {
    on<FetchNowplayingTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getNowPlayingTv.execute();
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tv) {
        emit(TvHasData(tv));
      });
    });
  }
}

class PopularTvBloc extends Bloc<TvEvent, TvState> {
  final GetPopularTv _getPopularTv;
  PopularTvBloc(this._getPopularTv) : super(TvLoading()) {
    on<FetchPopularTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getPopularTv.execute();
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tv) {
        emit(TvHasData(tv));
      });
    });
  }
}

class TopRatedTvBloc extends Bloc<TvEvent, TvState> {
  final GetTopRatedTv _getTopRatedTv;
  TopRatedTvBloc(this._getTopRatedTv) : super(TvLoading()) {
    on<FetchTopRatedTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getTopRatedTv.execute();
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tv) {
        emit(TvHasData(tv));
      });
    });
  }
}

class TvDetailBloc extends Bloc<TvEvent, TvState> {
  final GetTvDetail _getTvDetail;
  TvDetailBloc(this._getTvDetail) : super(TvLoading()) {
    on<FetchTvDetail>((event, emit) async {
      emit(TvLoading());
      final result = await _getTvDetail.execute(event.id);
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tv) {
        emit(TvDetailHasData(tv));
      });
    });
  }
}

class RecommendationTvBloc extends Bloc<TvEvent, TvState> {
  final GetTvRecommendations _getTvRecommendations;

  RecommendationTvBloc(this._getTvRecommendations) : super(TvEmpty()) {
    on<FetchTvRecommendation>((event, emit) async {
      emit(TvLoading());
      final result = await _getTvRecommendations.execute(event.id);
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tv) {
        emit(TvHasData(tv));
      });
    });
  }
}

class WatchlistTvBloc extends Bloc<TvEvent, TvState> {
  final GetWatchlistTv _getWatchListTv;
  final GetWatchListStatusTv _getWatchListStatusTv;
  final SaveWatchlistTv _saveWatchlistTv;
  final RemoveWatchlistTv _removeWatchlistTv;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistTvBloc(this._getWatchListTv, this._getWatchListStatusTv,
      this._saveWatchlistTv, this._removeWatchlistTv)
      : super(TvEmpty()) {
    on<FetchWatchListTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getWatchListTv.execute();
      result.fold((failure) {
        emit(TvHasError(failure.message));
      }, (tv) {
        emit(WatchlistTvHasData(tv));
      });
    });

    on<SaveWatchlistTvs>((event, emit) async {
      final tvmodel = event.tv;
      emit(TvLoading());
      final result = await _saveWatchlistTv.execute(tvmodel);

      result.fold((l) => emit(TvHasError(l.message)),
          (r) => emit(WatchlistTvMessage(r)));
    });

    on<RemoveWatchlistTvs>((event, emit) async {
      final tv = event.tv;
      emit(TvLoading());
      final result = await _removeWatchlistTv.execute(tv);

      result.fold((l) => emit(TvHasError(l.message)),
          (r) => emit(WatchlistTvMessage(r)));
    });

    on<LoadWatchlistTvStatus>((event, emit) async {
      final id = event.id;
      emit(TvLoading());
      final result = await _getWatchListStatusTv.execute(id);
      emit(LoadWatchlistTvData(result));
    });
  }
}
