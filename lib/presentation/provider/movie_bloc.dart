import 'package:tv_series/domain/entities/movie.dart';
import 'package:tv_series/domain/entities/movie_detail.dart';
import 'package:tv_series/domain/usecases/get_movie_detail.dart';
import 'package:tv_series/domain/usecases/get_movie_recommendations.dart';
import 'package:tv_series/domain/usecases/get_now_playing_movies.dart';
import 'package:tv_series/domain/usecases/get_popular_movies.dart';
import 'package:tv_series/domain/usecases/get_top_rated_movies.dart';
import 'package:tv_series/domain/usecases/get_watchlist_movies.dart';
import 'package:tv_series/domain/usecases/get_watchlist_status_movie.dart';
import 'package:tv_series/domain/usecases/remove_watchlist_movie.dart';
import 'package:tv_series/domain/usecases/save_watchlist_movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class NowPlayingMovieBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMovieBloc(this._getNowPlayingMovies) : super(MoviesLoading()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(MoviesLoading());
      final result = await _getNowPlayingMovies.execute();
      result.fold((failure) {
        emit(MoviesHasError(failure.message));
      }, (movies) {
        emit(MoviesHasData(movies));
      });
    });
  }
}

class PopularMovieBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetPopularMovies _getPopularMovies;

  PopularMovieBloc(this._getPopularMovies) : super(MoviesLoading()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(MoviesLoading());
      final result = await _getPopularMovies.execute();
      result.fold((failure) {
        emit(MoviesHasError(failure.message));
      }, (movies) {
        emit(MoviesHasData(movies));
      });
    });
  }
}

class TopRatedMovieBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMovieBloc(this._getTopRatedMovies) : super(MoviesLoading()) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(MoviesLoading());
      final result = await _getTopRatedMovies.execute();
      result.fold((failure) {
        emit(MoviesHasError(failure.message));
      }, (movies) {
        emit(MoviesHasData(movies));
      });
    });
  }
}

class DetailMovieBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetMovieDetail _getMovieDetail;
  DetailMovieBloc(this._getMovieDetail) : super(MoviesLoading()) {
    on<FetchDetailMovie>((event, emit) async {
      final id = event.id;
      emit(MoviesLoading());
      final result = await _getMovieDetail.execute(id);
      result.fold((failure) {
        emit(MoviesHasError(failure.message));
      }, (data) {
        emit(MovieDetailHasData(data));
      });
    });
  }
}

class RecommendationMovieBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetMovieRecommendations _getMovieRecommendations;
  RecommendationMovieBloc(this._getMovieRecommendations)
      : super(MoviesLoading()) {
    on<FetchMoviesRecommendation>((event, emit) async {
      final int id = event.id;
      emit(MoviesLoading());

      final result = await _getMovieRecommendations.execute(id);
      result.fold((l) {
        emit(MoviesHasError(l.message));
      }, (r) {
        emit(MoviesHasData(r));
      });
    });
  }
}

class WatchListMovieBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatusMovie _getWatchListStatusMovie;
  final SaveWatchlistMovie _saveWatchlistMovie;
  final RemoveWatchlistMovie _removeWatchlistMovie;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchListMovieBloc(this._getWatchlistMovies, this._getWatchListStatusMovie,
      this._saveWatchlistMovie, this._removeWatchlistMovie)
      : super(MoviesEmpty()) {
    on<FetchWatchlistMovies>(
          (event, emit) async {
        emit(MoviesLoading());

        final result = await _getWatchlistMovies.execute();
        result.fold((l) {
          emit(MoviesHasError(l.message));
        }, (r) {
          emit(WatchlistMovieHasData(r));
        });
      },
    );

    on<SaveWatchistMovies>((event, emit) async {
      final movie = event.movie;
      emit(MoviesLoading());
      final result = await _saveWatchlistMovie.execute(movie);

      result.fold((l) => emit(MoviesHasError(l.message)),
              (r) => emit(WatchlistMoviesMessage(r)));
    });

    on<RemoveWatchlistMovies>((event, emit) async {
      final movie = event.movie;
      emit(MoviesLoading());
      final result = await _removeWatchlistMovie.execute(movie);

      result.fold((l) => emit(MoviesHasError(l.message)),
              (r) => emit(WatchlistMoviesMessage(r)));
    });

    on<LoadWatchlistMovieStatus>((event, emit) async {
      final id = event.id;
      emit(MoviesLoading());
      final result = await _getWatchListStatusMovie.execute(id);

      emit(LoadWatchlistData(result));
    });
  }
}
