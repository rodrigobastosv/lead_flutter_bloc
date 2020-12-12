import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lead_weather/exception/weather_exception.dart';
import 'package:lead_weather/repository/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(
    this.repository,
  ) :  super(WeatherInitial());

  final WeatherRepository repository;

  void tryAgain() {
    emit(WeatherInitial());
  }

  Future<void> getWeatherFromLocation(String location) async {
    emit(WeatherLoading());
    try {
      final temperature = await repository.getWeather(location);
      emit(
        WeatherSuccess(
          temperature: temperature,
          location: location,
        ),
      );
    } on WeatherException catch (e) {
      emit(WeatherFailed(e.errorMessage));
    }
  }
}
