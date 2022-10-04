import 'package:TV_Series/domain/entities/tv.dart';
import 'package:TV_Series/domain/entities/tv_detail.dart';
import 'package:TV_Series/domain/usecases/get_tv_detail.dart';
import 'package:TV_Series/domain/usecases/get_tv_recommendations.dart';
import 'package:TV_Series/common/state_enum.dart';
import 'package:TV_Series/domain/usecases/get_watchlist_status_tv.dart';
import 'package:TV_Series/domain/usecases/remove_watchlist_tv.dart';
import 'package:TV_Series/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistoAddSuccessMessage = 'Added to Watchlist';
  static const watchlistoRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListStatus getWatchListoStatus;
  final SaveWatchlist saveWatchlisto;
  final RemoveWatchlist removeWatchlisto;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListoStatus,
    required this.saveWatchlisto,
    required this.removeWatchlisto,
  });

  late TvDetail _tv;
  TvDetail get tv => _tv;

  RequestState _tvState = RequestState.Empty;
  RequestState get tvState => _tvState;

  List<Tv> _tvRecommendations = [];
  List<Tv> get tvRecommendations => _tvRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlisto = false;
  bool get isAddedToWatchlisto => _isAddedtoWatchlisto;

  Future<void> fetchTvDetail(int id) async {
    _tvState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _recommendationState = RequestState.Loading;
        _tv = tv;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (tv) {
            _recommendationState = RequestState.Loaded;
            _tvRecommendations = tv;
          },
        );
        _tvState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistoMessage = '';
  String get watchlistoMessage => _watchlistoMessage;

  Future<void> addWatchlist(TvDetail tv) async {
    final result = await saveWatchlisto.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistoMessage = failure.message;
      },
      (successMessage) async {
        _watchlistoMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(TvDetail tv) async {
    final result = await removeWatchlisto.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistoMessage = failure.message;
      },
      (successMessage) async {
        _watchlistoMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListoStatus.execute(id);
    _isAddedtoWatchlisto = result;
    notifyListeners();
  }
}
