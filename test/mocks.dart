import 'package:bloc_test/bloc_test.dart';
import 'package:lead_weather/cubit/weather_cubit.dart';
import 'package:lead_weather/repository/weather_repository.dart';
import 'package:mockito/mockito.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockWeatherCubit extends MockBloc<WeatherState> implements WeatherCubit {}