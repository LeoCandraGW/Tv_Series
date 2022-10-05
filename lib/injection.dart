import 'package:TV_Series/data/datasources/db/database_helper_tv.dart';
import 'package:TV_Series/data/datasources/tv_local_data_source.dart';
import 'package:TV_Series/data/datasources/tv_remote_data_source.dart';
import 'package:TV_Series/data/repositories/tv_repository_impl.dart';
import 'package:TV_Series/domain/repositories/tv_repository.dart';
import 'package:TV_Series/domain/usecases/get_tv_detail.dart';
import 'package:TV_Series/domain/usecases/get_tv_recommendations.dart';
import 'package:TV_Series/domain/usecases/get_now_playing_tv.dart';
import 'package:TV_Series/domain/usecases/get_popular_tv.dart';
import 'package:TV_Series/domain/usecases/get_top_rated_tv.dart';
import 'package:TV_Series/domain/usecases/get_watchlist_tv.dart';
import 'package:TV_Series/domain/usecases/get_watchlist_status_tv.dart';
import 'package:TV_Series/domain/usecases/remove_watchlist_tv.dart';
import 'package:TV_Series/domain/usecases/save_watchlist_tv.dart';
import 'package:TV_Series/domain/usecases/search_tv.dart';
import 'package:TV_Series/presentation/provider/tv_detail_notifier.dart';
import 'package:TV_Series/presentation/provider/tv_list_notifier.dart';
import 'package:TV_Series/presentation/provider/tv_search_notifier.dart';
import 'package:TV_Series/presentation/provider/popular_tv_notifier.dart';
import 'package:TV_Series/presentation/provider/top_rated_tv_notifier.dart';
import 'package:TV_Series/presentation/provider/watchlist_tv_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => TvListNotifier(
      getNowPlayingTv: locator(),
      getPopularTv: locator(),
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchListoStatus: locator(),
      saveWatchlisto: locator(),
      removeWatchlisto: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchNotifier(
      searchTv: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvNotifier(
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvNotifier(
      getWatchlistoTv: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // repository
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      TvremoteDataSource: locator(),
      TvlocalDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
