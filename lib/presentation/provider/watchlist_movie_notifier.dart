import 'package:TV_Series/common/state_enum.dart';
import 'package:TV_Series/domain/entities/tv.dart';
import 'package:TV_Series/domain/usecases/get_watchlist_tv.dart';
import 'package:flutter/foundation.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  var _watchlistoTv = <Tv>[];
  List<Tv> get watchlistoTv => _watchlistoTv;

  var _watchlistoState = RequestState.Empty;
  RequestState get watchlistoState => _watchlistoState;

  String _message = '';
  String get message => _message;

  WatchlistTvNotifier({required this.getWatchlistoTv});

  final GetWatchlistTv getWatchlistoTv;

  Future<void> fetchWatchlistTv() async {
    _watchlistoState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistoTv.execute();
    result.fold(
      (failure) {
        _watchlistoState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _watchlistoState = RequestState.Loaded;
        _watchlistoTv = tvData;
        notifyListeners();
      },
    );
  }
}
