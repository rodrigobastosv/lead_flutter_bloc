import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lead_weather/cubit/weather_cubit.dart';
import 'package:lead_weather/page/weather_page/weather_view.dart';
import 'package:mockito/mockito.dart';

import '../../mocks.dart';

void main() {
  group('WeatherPage tests', () {
    testWidgets(
      'should build WeatherView withou exploding',
      (tester) async {
        final cubit = MockWeatherCubit();
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<WeatherCubit>(
              create: (_) => cubit,
              child: WeatherView(),
            ),
          ),
        );
        expect(find.byType(TextFormField), findsOneWidget);
      },
    );

    testWidgets(
      'show CircularProgressIndicator while Loading',
      (tester) async {
        final cubit = MockWeatherCubit();
        when(cubit.state).thenReturn(WeatherLoading());
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<WeatherCubit>(
              create: (_) => cubit,
              child: WeatherView(),
            ),
          ),
        );
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'show error message when things go wrong',
      (tester) async {
        final cubit = MockWeatherCubit();
        when(cubit.state).thenReturn(WeatherFailed('Deu ruim'));
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<WeatherCubit>(
              create: (_) => cubit,
              child: WeatherView(),
            ),
          ),
        );
        expect(find.text('Deu ruim'), findsOneWidget);
      },
    );
  });
}
