part of 'weather_cubit.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherSuccess extends WeatherState {
  WeatherSuccess({
    @required this.temperature,
    @required this.location,
  })  : assert(temperature != null),
        assert(location != null);

  final String temperature;
  final String location;

  @override
  List<Object> get props => [temperature, location];
}

class WeatherFailed extends WeatherState {
  WeatherFailed(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
