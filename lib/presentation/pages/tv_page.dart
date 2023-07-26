import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/provider/tv_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';

class TvPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv';

  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<NowPlayingTvBloc>().add(FetchNowplayingTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvBloc, TvState>(
          builder: (context, state) {
            if (state is TvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvs = state.tvs[index];
                  return TvCard(tvs);
                },
                itemCount: state.tvs.length,
              );
            } else if (state is TvHasError){
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Text('Data Tidak Ada');
            }
          },
        ),
      ),
    );
  }
}
