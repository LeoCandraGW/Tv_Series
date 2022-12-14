import 'package:bloc_test/bloc_test.dart';

import 'package:dartz/dartz.dart';
import 'package:tv_series/common/failure.dart';
import 'package:tv_series/domain/entities/genre.dart';
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
import 'package:tv_series/presentation/provider/movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


import 'movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetNowPlayingMovies,
  GetTopRatedMovies,
  GetPopularMovies,
  GetWatchlistMovies,
  GetWatchListStatusMovie,
  RemoveWatchlistMovie,
  SaveWatchlistMovie,
])
void main() {
  late NowPlayingMovieBloc nowPlayingMoviesBloc;
  late PopularMovieBloc popularMoviesBloc;
  late TopRatedMovieBloc topRatedMoviesBloc;
  late DetailMovieBloc detailMovieBloc;
  late RecommendationMovieBloc recommendationMovieBloc;
  late WatchListMovieBloc watchListBloc;

  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockRemoveWatchlist mockRemoveWatchlistMovies;
  late MockSaveWatchlist mockSaveWatchistMovies;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockSaveWatchistMovies = MockSaveWatchlist();
    mockRemoveWatchlistMovies = MockRemoveWatchlist();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();

    nowPlayingMoviesBloc = NowPlayingMovieBloc(mockGetNowPlayingMovies);
    popularMoviesBloc = PopularMovieBloc(mockGetPopularMovies);
    topRatedMoviesBloc = TopRatedMovieBloc(mockGetTopRatedMovies);
    recommendationMovieBloc =
        RecommendationMovieBloc(mockGetMovieRecommendations);
    detailMovieBloc = DetailMovieBloc(mockGetMovieDetail);
    watchListBloc = WatchListMovieBloc(
        mockGetWatchlistMovies,
        mockGetWatchListStatus,
        mockSaveWatchistMovies,
        mockRemoveWatchlistMovies);
  });
  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovieList = <Movie>[tMovie];

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
    genres: [Genre(id: 1, name: 'name')],
  );

  final tId = 1;

  group('Get now playing movies', () {
    test('initial state must be empty', () {
      expect(nowPlayingMoviesBloc.state, MoviesLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return nowPlayingMoviesBloc;
      },
      act: (NowPlayingMovieBloc bloc) => bloc.add(FetchNowPlayingMovies()),
      wait: Duration(milliseconds: 500),
      expect: () => [MoviesLoading(), MoviesHasData(tMovieList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
                (realInvocation) async => Left(ServerFailure('Server Failure')));
        return nowPlayingMoviesBloc;
      },
      act: (NowPlayingMovieBloc bloc) => bloc.add(FetchNowPlayingMovies()),
      wait: Duration(milliseconds: 500),
      expect: () => [
        MoviesLoading(),
        MoviesHasError('Server Failure'),
      ],
      verify: (NowPlayingMovieBloc bloc) =>
          verify(mockGetNowPlayingMovies.execute()),
    );
  });

  group('Get Popular movies', () {
    test('initial state must be empty', () {
      expect(popularMoviesBloc.state, MoviesLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return popularMoviesBloc;
      },
      act: (PopularMovieBloc bloc) => bloc.add(FetchPopularMovies()),
      wait: Duration(milliseconds: 500),
      expect: () => [MoviesLoading(), MoviesHasData(tMovieList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
                (realInvocation) async => Left(ServerFailure('Server Failure')));
        return popularMoviesBloc;
      },
      act: (PopularMovieBloc bloc) => bloc.add(FetchPopularMovies()),
      wait: Duration(milliseconds: 500),
      expect: () => [
        MoviesLoading(),
        const MoviesHasError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetPopularMovies.execute()),
    );
  });

  group('Get Top Rated movies', () {
    test('initial state must be empty', () {
      expect(topRatedMoviesBloc.state, MoviesLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedMoviesBloc;
      },
      act: (TopRatedMovieBloc bloc) => bloc.add(FetchTopRatedMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [MoviesLoading(), MoviesHasData(tMovieList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
                (realInvocation) async => Left(ServerFailure('Server Failure')));
        return topRatedMoviesBloc;
      },
      act: (TopRatedMovieBloc bloc) => bloc.add(FetchTopRatedMovies()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MoviesLoading(),
        const MoviesHasError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetTopRatedMovies.execute()),
    );
  });

  group('Get Recommended movies', () {
    test('initial state must be empty', () {
      expect(recommendationMovieBloc.state, MoviesLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovieList));
        return recommendationMovieBloc;
      },
      act: (RecommendationMovieBloc bloc) =>
          bloc.add(FetchMoviesRecommendation(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [MoviesLoading(), MoviesHasData(tMovieList)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
                (realInvocation) async => Left(ServerFailure('Server Failure')));
        return recommendationMovieBloc;
      },
      act: (RecommendationMovieBloc bloc) =>
          bloc.add(FetchMoviesRecommendation(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MoviesLoading(),
        const MoviesHasError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetMovieRecommendations.execute(tId)),
    );
  });

  group('Get Details movies', () {
    test('initial state must be empty', () {
      expect(detailMovieBloc.state, MoviesLoading());
    });

    blocTest(
      'should emit[loading, movieHasData] when data is gotten succesfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(tMovieDetail));
        return detailMovieBloc;
      },
      act: (DetailMovieBloc bloc) => bloc.add(FetchDetailMovie(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [MoviesLoading(), MovieDetailHasData(tMovieDetail)],
    );

    blocTest(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
                (realInvocation) async => Left(ServerFailure('Server Failure')));
        return detailMovieBloc;
      },
      act: (DetailMovieBloc bloc) => bloc.add(FetchDetailMovie(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MoviesLoading(),
        const MoviesHasError('Server Failure'),
      ],
      verify: (bloc) => verify(mockGetMovieDetail.execute(tId)),
    );
  });

  group('Get Watchlist movies', () {
    test('initial state must be empty', () {
      expect(watchListBloc.state, MoviesEmpty());
    });

    group('Watchlist Movie', () {
      test('initial state should be empty', () {
        expect(watchListBloc.state, MoviesEmpty());
      });

      group('Fetch Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockGetWatchlistMovies.execute())
                .thenAnswer((_) async => Right(tMovieList));
            return watchListBloc;
          },
          act: (WatchListMovieBloc bloc) => bloc.add(FetchWatchlistMovies()),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            MoviesLoading(),
            WatchlistMovieHasData(tMovieList),
          ],
          verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockGetWatchlistMovies.execute())
                .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
            return watchListBloc;
          },
          act: (WatchListMovieBloc bloc) => bloc.add(FetchWatchlistMovies()),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            MoviesLoading(),
            const MoviesHasError('Server Failure'),
          ],
          verify: (bloc) => verify(mockGetWatchlistMovies.execute()),
        );
      });

      group('Load Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockGetWatchListStatus.execute(tId))
                .thenAnswer((_) async => true);
            return watchListBloc;
          },
          act: (WatchListMovieBloc bloc) => bloc.add(LoadWatchlistMovieStatus(tId)),
          wait: const Duration(milliseconds: 500),
          expect: () => [
            MoviesLoading(),
            LoadWatchlistData(true),
          ],
          verify: (bloc) => verify(mockGetWatchListStatus.execute(tId)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockGetWatchListStatus.execute(tId))
                .thenAnswer((_) async => false);
            return watchListBloc;
          },
          act: (WatchListMovieBloc bloc) => bloc.add(LoadWatchlistMovieStatus(tId)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            MoviesLoading(),
            LoadWatchlistData(false),
          ],
          verify: (bloc) => verify(mockGetWatchListStatus.execute(tId)),
        );
      });

      group('Save Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockSaveWatchistMovies.execute(tMovieDetail)).thenAnswer(
                    (_) async => Right(WatchListMovieBloc.watchlistAddSuccessMessage));
            return watchListBloc;
          },
          act: (WatchListMovieBloc bloc) =>
              bloc.add(SaveWatchistMovies(tMovieDetail)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            MoviesLoading(),
            WatchlistMoviesMessage(WatchListMovieBloc.watchlistAddSuccessMessage),
          ],
          verify: (bloc) =>
              verify(mockSaveWatchistMovies.execute(tMovieDetail)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockSaveWatchistMovies.execute(tMovieDetail))
                .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
            return watchListBloc;
          },
          act: (WatchListMovieBloc bloc) =>
              bloc.add(SaveWatchistMovies(tMovieDetail)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            MoviesLoading(),
            MoviesHasError('Server Failure'),
          ],
          verify: (bloc) =>
              verify(mockSaveWatchistMovies.execute(tMovieDetail)),
        );
      });

      group('Remove Watchlist Movie', () {
        blocTest(
          'Should emit [Loading, HasData] when data is gotten successfully',
          build: () {
            when(mockRemoveWatchlistMovies.execute(tMovieDetail)).thenAnswer(
                    (_) async => Right(WatchListMovieBloc.watchlistAddSuccessMessage));
            return watchListBloc;
          },
          act: (WatchListMovieBloc bloc) =>
              bloc.add(RemoveWatchlistMovies(tMovieDetail)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            MoviesLoading(),
            WatchlistMoviesMessage(WatchListMovieBloc.watchlistAddSuccessMessage),
          ],
          verify: (bloc) =>
              verify(mockRemoveWatchlistMovies.execute(tMovieDetail)),
        );

        blocTest(
          'Should emit [Loading, Error] when get search is unsuccessful',
          build: () {
            when(mockRemoveWatchlistMovies.execute(tMovieDetail))
                .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
            return watchListBloc;
          },
          act: (WatchListMovieBloc bloc) =>
              bloc.add(RemoveWatchlistMovies(tMovieDetail)),
          wait: Duration(milliseconds: 500),
          expect: () => [
            MoviesLoading(),
            MoviesHasError('Server Failure'),
          ],
          verify: (bloc) =>
              verify(mockRemoveWatchlistMovies.execute(tMovieDetail)),
        );
      });
    });
  });
}
