import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lead_weather/cubit/weather_cubit.dart';

import 'widget/temperature_result.dart';

class WeatherView extends StatefulWidget {
  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  String _location;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lead Weather App'),
        centerTitle: true,
      ),
      body: Center(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (_, state) {
            if (state is WeatherLoading) {
              return _getWidgetLoadingState(state);
            } else if (state is WeatherFailed) {
              return _getWidgetErrorState(state);
            } else if (state is WeatherInitial) {
              return _getWidgetInitialState(state);
            } else if (state is WeatherSuccess) {
              return _getWidgetSuccessState(state);
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  Widget _getWidgetInitialState(WeatherInitial state) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (location) =>
                  location.isEmpty ? 'Required Field' : null,
              onSaved: (location) => _location = location,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                hintText: 'Location',
                labelText: 'Location',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      context
                          .read<WeatherCubit>()
                          .getWeatherFromLocation(_location);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getWidgetSuccessState(WeatherSuccess state) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (location) =>
                  location.isEmpty ? 'Required Field' : null,
              onSaved: (location) => _location = location,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                hintText: 'Location',
                labelText: 'Location',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      context
                          .read<WeatherCubit>()
                          .getWeatherFromLocation(_location);
                    }
                  },
                ),
              ),
            ),
            if (state is WeatherSuccess)
              TemperatureResult(
                location: state.location,
                temperature: state.temperature,
              ),
          ],
        ),
      ),
    );
  }

  Widget _getWidgetLoadingState(WeatherLoading state) => Center(
        child: CircularProgressIndicator(),
      );

  Widget _getWidgetErrorState(WeatherFailed state) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.errorMessage),
            TextButton(
              onPressed: () => context.read<WeatherCubit>().tryAgain(),
              child: Text(
                'Try Again!',
              ),
            ),
          ],
        ),
      );
}
