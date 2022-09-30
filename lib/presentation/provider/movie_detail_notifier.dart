import 'package:TV_Series/domain/entities/movie.dart';
import 'package:TV_Series/domain/entities/movie_detail.dart';
import 'package:TV_Series/domain/usecases/get_movie_detail.dart';
import 'package:TV_Series/domain/usecases/get_movie_recommendations.dart';
import 'package:TV_Series/common/state_enum.dart';
import 'package:TV_Series/domain/usecases/get_watchlist_status.dart';
import 'package:TV_Series/domain/usecases/remove_watchlist.dart';
import 'package:TV_Series/domain/usecases/save_watchlist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MovieDetailNotifier extends ChangeNotifier {
  static const watchlistoAddSuccessMessage = 'Added to Watchlist';
  static const watchlistoRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListoStatus;
  final SaveWatchlist saveWatchlisto;
  final RemoveWatchlist removeWatchlisto;

  MovieDetailNotifier({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListoStatus,
    required this.saveWatchlisto,
    required this.removeWatchlisto,
  });

  late MovieDetail _movie;
  MovieDetail get movie => _movie;

  RequestState _movieState = RequestState.Empty;
  RequestState get movieState => _movieState;

  List<Movie> _movieRecommendations = [];
  List<Movie> get movieRecommendations => _movieRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlisto = false;
  bool get isAddedToWatchlisto => _isAddedtoWatchlisto;

  Future<void> fetchMovieDetail(int id) async {
    _movieState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getMovieDetail.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _movieState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (movie) {
        _recommendationState = RequestState.Loading;
        _movie = movie;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (movies) {
            _recommendationState = RequestState.Loaded;
            _movieRecommendations = movies;
          },
        );
        _movieState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistoMessage = '';
  String get watchlistoMessage => _watchlistoMessage;

  Future<void> addWatchlist(MovieDetail movie) async {
    final result = await saveWatchlisto.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistoMessage = failure.message;
      },
      (successMessage) async {
        _watchlistoMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchlisto.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistoMessage = failure.message;
      },
      (successMessage) async {
        _watchlistoMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListoStatus.execute(id);
    _isAddedtoWatchlisto = result;
    notifyListeners();
  }
}
