part of 'temperature_cubit.dart';

abstract class TemperatureState extends Equatable {
  const TemperatureState();

  @override
  List<Object> get props => [];
}

class TemperatureInitial extends TemperatureState {}

class TemperatureChanged extends TemperatureState {
  TemperatureChanged(this.newTemperature);

  final String newTemperature;

  @override
  List<Object> get props => [newTemperature];
}
