import 'package:firebase_core/firebase_core.dart';
import 'package:tv_series/common/constants.dart';
import 'package:tv_series/common/ssl_helper.dart';
import 'package:tv_series/common/utils.dart';
import 'package:tv_series/presentation/pages/about_page.dart';
import 'package:tv_series/presentation/pages/home_movie_page.dart';
import 'package:tv_series/presentation/pages/main_home.dart';
import 'package:tv_series/presentation/pages/movies_page.dart';
import 'package:tv_series/presentation/pages/tv_detail_page.dart';
import 'package:tv_series/presentation/pages/home_tv_page.dart';
import 'package:tv_series/presentation/pages/popular_tv_page.dart';
import 'package:tv_series/presentation/pages/search_tv_page.dart';
import 'package:tv_series/presentation/pages/top_rated_tv_page.dart';
import 'package:tv_series/presentation/pages/tv_page.dart';
import 'package:tv_series/presentation/pages/watchlist_tv_page.dart';
import 'package:tv_series/presentation/pages/movie_detail_page.dart';
import 'package:tv_series/presentation/pages/popular_movies_page.dart';
import 'package:tv_series/presentation/pages/search_movie_page.dart';
import 'package:tv_series/presentation/pages/top_rated_movies_page.dart';
import 'package:tv_series/presentation/pages/watchlist_movies_page.dart';
import 'package:tv_series/presentation/provider/tv_bloc.dart';
import 'package:tv_series/presentation/provider/search_bloc.dart';
import 'package:tv_series/presentation/provider/movie_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SslHelper.initializing();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //tv
        BlocProvider(create: (_)=> di.locator<PopularTvBloc>()),
        BlocProvider(create: (_)=> di.locator<TopRatedTvBloc>()),
        BlocProvider(create: (_)=> di.locator<NowPlayingTvBloc>()),
        BlocProvider(create: (_)=> di.locator<TvDetailBloc>()),
        BlocProvider(create: (_)=> di.locator<RecommendationTvBloc>()),
        BlocProvider(create: (_)=> di.locator<WatchlistTvBloc>()),
        BlocProvider(create: (_)=> di.locator<SearchTvBloc>()),

        //movie
        BlocProvider(create: (_) => di.locator<SearchMovieBloc>()),
        BlocProvider(create: (_) => di.locator<NowPlayingMovieBloc>()),
        BlocProvider(create: (_) => di.locator<PopularMovieBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedMovieBloc>()),
        BlocProvider(create: (_) => di.locator<DetailMovieBloc>()),
        BlocProvider(create: (_) => di.locator<RecommendationMovieBloc>()),
        BlocProvider(create: (_) => di.locator<WatchListMovieBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: MainHome(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/hometv':
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case '/homemovie':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());
            case MainHome.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => MainHome());
            case TopRatedTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case SearchPageTv.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPageTv());
            case WatchlistTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => MoviesPage());
            case TvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TvPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPageMovie.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPageMovie());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
