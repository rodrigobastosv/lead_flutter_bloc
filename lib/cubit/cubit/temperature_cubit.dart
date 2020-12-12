import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'temperature_state.dart';

class TemperatureCubit extends Cubit<TemperatureState> {
  TemperatureCubit() : super(TemperatureInitial());
}
