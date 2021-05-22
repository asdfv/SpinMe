import 'package:domain/domain_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/bloc/wheel_event.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/bloc/wheel_state.dart';

class WheelBloc extends Bloc<WheelEvent, WheelState> {
  final WheelCoordinator coordinator;

  WheelBloc(this.coordinator) : super(InitialState("Spin the wheel!"));

  @override
  Stream<WheelState> mapEventToState(WheelEvent event) async* {
    if (event is SpinFinished) {
      final item = event.item;
      final task = await coordinator.pickTask();
      yield PersonPickedState(item.label, task);
    } if (event is SpinStarted) {
      yield SpinInProgressState("Yeeeha!");
    }
  }
}
