import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lead_weather/cubit/weather_cubit.dart';
import 'package:lead_weather/repository/weather_repository.dart';

import 'weather_view.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherCubit>(
      create: (_) => WeatherCubit(
        context.read<WeatherRepository>(),
      )..getWeatherFromLocation('london'),
      child: WeatherView(),
    );
  }
}
