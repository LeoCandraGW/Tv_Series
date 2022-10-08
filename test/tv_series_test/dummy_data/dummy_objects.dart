import 'package:tv_series/data/models/tv_table.dart';
import 'package:tv_series/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';

final testTv = Tv(
  backdropPath: '/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg',
  genreIds: [10765, 18, 10759],
  id: 94997,
  originalName: 'House of the Dragon',
  overview:
      'The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.',
  popularity: 5486.161,
  posterPath: '/z2yahl2uefxDCl0nogcRBstwruJ.jpg',
  name: 'House of the Dragon',
  voteAverage: 8.6,
  voteCount: 1584,
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  homepage: "https://google.com",
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  episodeRunTime: [1, 2, 3],
  firstAirDate: 'firstAirDate',
  lastAirDate: 'lastAirDate',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  inProduction: false,
  languages: ["en"],
  type: 'type',
  posterPath: 'posterPath',
  status: 'Status',
  tagline: 'Tagline',
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistTv = Tv.watchlisto(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
