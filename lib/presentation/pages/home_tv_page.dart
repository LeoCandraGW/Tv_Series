import 'package:cached_network_image/cached_network_image.dart';
import 'package:tv_series/common/constants.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/presentation/pages/about_page.dart';
import 'package:tv_series/presentation/pages/tv_detail_page.dart';
import 'package:tv_series/presentation/pages/popular_tv_page.dart';
import 'package:tv_series/presentation/pages/search_tv_page.dart';
import 'package:tv_series/presentation/pages/top_rated_tv_page.dart';
import 'package:tv_series/presentation/pages/tv_page.dart';
import 'package:tv_series/presentation/pages/watchlist_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/presentation/provider/tv_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_home.dart';

class HomeTvPage extends StatefulWidget {
  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () {
          context.read<NowPlayingTvBloc>().add(FetchNowplayingTv());
          context.read<PopularTvBloc>().add(FetchPopularTv());
          context.read<TopRatedTvBloc>().add(FetchTopRatedTv());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('TVSeries'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, MainHome.ROUTE_NAME);
              },
              leading: Icon(Icons.arrow_back_ios_new_outlined),
              title: Text('Home'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('TVSeries of Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPageTv.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Tv Series',
                onTap: () =>
                    Navigator.pushNamed(context, TvPage.ROUTE_NAME),
              ),
              BlocBuilder<NowPlayingTvBloc, TvState>(
                builder: (context, state) {
                if (state is TvLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvHasData) {
                  return TvList(state.tvs);
                } else if (state is TvHasError){
                  return Text(state.message);
                } else {
                  return Text('Data Tidak Ada');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvBloc, TvState>(
                builder: (context, state) {
                if (state is TvLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvHasData) {
                  return TvList(state.tvs);
                } else if (state is TvHasError){
                  return Text(state.message);
                } else {
                  return Text('Data Tidak Ada');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvBloc, TvState>(
                builder: (context, state) {
                if (state is TvLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvHasData) {
                  return TvList(state.tvs);
                } else if (state is TvHasError){
                  return Text(state.message);
                } else {
                  return Text('Data Tidak Ada');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvs;

  TvList(this.tvs);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
