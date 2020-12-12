import 'dart:math';

import 'package:lead_weather/exception/weather_exception.dart';

class WeatherRepository {
  Future<String> getWeather(String location) async {
    bool isSuccess = Random().nextBool();
    await Future.delayed(Duration(seconds: 1));
    if (isSuccess) {
      int temperature = Random().nextInt(255);
      return '$temperature °';
    } else {
      throw WeatherException('Could not fetch weather from location');
    }
  }
}
