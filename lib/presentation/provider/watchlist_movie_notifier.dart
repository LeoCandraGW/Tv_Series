import 'package:TV_Series/common/state_enum.dart';
import 'package:TV_Series/domain/entities/movie.dart';
import 'package:TV_Series/domain/usecases/get_watchlist_movies.dart';
import 'package:flutter/foundation.dart';

class WatchlistMovieNotifier extends ChangeNotifier {
  var _watchlistoMovies = <Movie>[];
  List<Movie> get watchlistoMovies => _watchlistoMovies;

  var _watchlistoState = RequestState.Empty;
  RequestState get watchlistoState => _watchlistoState;

  String _message = '';
  String get message => _message;

  WatchlistMovieNotifier({required this.getWatchlistoMovies});

  final GetWatchlistMovies getWatchlistoMovies;

  Future<void> fetchWatchlistMovies() async {
    _watchlistoState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistoMovies.execute();
    result.fold(
      (failure) {
        _watchlistoState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistoState = RequestState.Loaded;
        _watchlistoMovies = moviesData;
        notifyListeners();
      },
    );
  }
}
