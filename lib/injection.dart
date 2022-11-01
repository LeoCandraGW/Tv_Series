import 'package:tv_series/common/ssl_helper.dart';
import 'package:tv_series/data/datasources/db/database_helper_tv.dart';
import 'package:tv_series/data/datasources/tv_local_data_source.dart';
import 'package:tv_series/data/datasources/tv_remote_data_source.dart';
import 'package:tv_series/data/repositories/tv_repository_impl.dart';
import 'package:tv_series/domain/repositories/tv_repository.dart';
import 'package:tv_series/domain/usecases/get_tv_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_recommendations.dart';
import 'package:tv_series/domain/usecases/get_now_playing_tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tv.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv.dart';
import 'package:tv_series/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv_series/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv_series/domain/usecases/save_watchlist_tv.dart';
import 'package:tv_series/domain/usecases/search_tv.dart';
import 'package:tv_series/data/datasources/db/database_helper_movie.dart';
import 'package:tv_series/data/datasources/movie_local_data_source.dart';
import 'package:tv_series/data/datasources/movie_remote_data_source.dart';
import 'package:tv_series/data/repositories/movie_repository_impl.dart';
import 'package:tv_series/domain/repositories/movie_repository.dart';
import 'package:tv_series/domain/usecases/get_movie_detail.dart';
import 'package:tv_series/domain/usecases/get_movie_recommendations.dart';
import 'package:tv_series/domain/usecases/get_now_playing_movies.dart';
import 'package:tv_series/domain/usecases/get_popular_movies.dart';
import 'package:tv_series/domain/usecases/get_top_rated_movies.dart';
import 'package:tv_series/domain/usecases/get_watchlist_movies.dart';
import 'package:tv_series/domain/usecases/get_watchlist_status_movie.dart';
import 'package:tv_series/domain/usecases/remove_watchlist_movie.dart';
import 'package:tv_series/domain/usecases/save_watchlist_movie.dart';
import 'package:tv_series/domain/usecases/search_movies.dart';
import 'package:tv_series/presentation/provider/tv_bloc.dart';
import 'package:tv_series/presentation/provider/search_bloc.dart';
import 'package:tv_series/presentation/provider/movie_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  //tv
  locator.registerFactory(() => NowPlayingTvBloc(locator()));
  locator.registerFactory(() => SearchTvBloc(locator()));
  locator.registerFactory(() => PopularTvBloc(locator()));
  locator.registerFactory(() => TopRatedTvBloc(locator()));
  locator.registerFactory(() => TvDetailBloc(locator()));
  locator.registerFactory(() => RecommendationTvBloc(locator()));
  locator.registerFactory(() => WatchlistTvBloc(
    locator(),
    locator(),
    locator(),
    locator(),
  ));
  //movie
  locator.registerFactory(() => SearchMovieBloc(locator()));
  locator.registerFactory(() => NowPlayingMovieBloc(locator()));
  locator.registerFactory(() => PopularMovieBloc(locator()));
  locator.registerFactory(() => TopRatedMovieBloc(locator()));
  locator.registerFactory(() => DetailMovieBloc(locator()));
  locator.registerFactory(() => RecommendationMovieBloc(locator()));
  locator.registerFactory(() => WatchListMovieBloc(
    locator(),
    locator(),
    locator(),
    locator(),
  ));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusMovie(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // repository
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      tvremoteDataSource: locator(),
      tvlocalDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      movieremoteDataSource: locator(),
      movielocalDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelperMovie: locator()));
  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperMovie>(() => DatabaseHelperMovie());

  // external
  locator.registerLazySingleton(() => SslHelper.client);
}
