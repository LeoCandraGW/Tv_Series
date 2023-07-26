import 'package:tv_series/common/exception.dart';
import 'package:tv_series/data/datasources/db/database_helper_movie.dart';
import 'package:tv_series/data/models/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlistMovie(MovieTable movie);
  Future<String> removeWatchlistMovie(MovieTable movie);
  Future<MovieTable?> getMovieById(int id);
  Future<List<MovieTable>> getWatchlistMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelperMovie databaseHelperMovie;

  MovieLocalDataSourceImpl({required this.databaseHelperMovie});

  @override
  Future<String> insertWatchlistMovie(MovieTable movie) async {
    try {
      await databaseHelperMovie.insertWatchlistMovie(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistMovie(MovieTable movie) async {
    try {
      await databaseHelperMovie.removeWatchlistMovie(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await databaseHelperMovie.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await databaseHelperMovie.getWatchlistMovies();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }
}
