import 'package:tv_series/presentation/pages/tv_page.dart';
import 'package:tv_series/presentation/provider/tv_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper_tv_bloc.dart';



void main() {
  late OnAirNowBlocHelper onAirNowBlocHelper;
  setUpAll(() {
    onAirNowBlocHelper = OnAirNowBlocHelper();
    registerFallbackValue(OnAirNowStateHelper());
    registerFallbackValue(OnAirNowEventHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingTvBloc>(
      create: (_) => onAirNowBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    onAirNowBlocHelper.close();
  });

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(() => onAirNowBlocHelper.state).thenReturn(TvLoading());

        final progressBarFinder = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(TvPage()));

        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {
        when(() => onAirNowBlocHelper.state).thenReturn(TvLoading());
        when(() => onAirNowBlocHelper.state).thenReturn(TvHasData(testTvList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(TvPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(() => onAirNowBlocHelper.state)
            .thenReturn(TvHasError('Error message'));

        final textFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(TvPage()));

        expect(textFinder, findsOneWidget);
      });
}
