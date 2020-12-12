import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lead_weather/cubit/weather_cubit.dart';
import 'package:lead_weather/exception/weather_exception.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';

void main() {
  MockWeatherRepository mockWeatherRepository;

  group('WeatherCubit tests', () {
    setUp(() {
      mockWeatherRepository = MockWeatherRepository();
    });

    blocTest(
      'CounterCubit emits [WeatherInitial] when called tryAgain',
      build: () => WeatherCubit(mockWeatherRepository),
      act: (cubit) => cubit.tryAgain(),
      expect: [
        WeatherInitial(),
      ],
    );

    group('getWeatherFromLocation states', () {
      blocTest(
        'emits [WeatherLoading, WeatherSuccess] when success',
        build: () {
          when(mockWeatherRepository.getWeather(any))
              .thenAnswer((_) => Future.value('10°'));
          return WeatherCubit(mockWeatherRepository);
        },
        act: (cubit) => cubit.getWeatherFromLocation('London'),
        expect: [
          WeatherLoading(),
          WeatherSuccess(
            temperature: '10°',
            location: 'London',
          ),
        ],
        verify: (cubit) {
          verify(mockWeatherRepository.getWeather('London')).called(1);
        },
      );

      blocTest(
        'emits [WeatherLoading, WeatherFailed] when failed',
        build: () {
          when(mockWeatherRepository.getWeather(any)).thenThrow(
              WeatherException('Could not fetch weather from location'));
          return WeatherCubit(mockWeatherRepository);
        },
        act: (cubit) => cubit.getWeatherFromLocation('London'),
        expect: [
          WeatherLoading(),
          WeatherFailed('Could not fetch weather from location'),
        ],
        verify: (cubit) {
          verify(mockWeatherRepository.getWeather('London')).called(1);
        },
      );
    });
  });
}
