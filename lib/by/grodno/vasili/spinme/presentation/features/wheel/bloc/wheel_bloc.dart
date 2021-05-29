import 'package:domain/domain_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/bloc/wheel_event.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/bloc/wheel_state.dart';

class WheelBloc extends Bloc<WheelEvent, WheelState> {
  WheelBloc(this.coordinator) : super(InitialState("Spin the wheel!"));

  final WheelCoordinator coordinator;

  @override
  Stream<WheelState> mapEventToState(WheelEvent event) async* {
    if (event is SpinFinished) {
      final task = coordinator.pickTask();
      final player = coordinator.pickPlayer(event.item.id);
      yield PlayerPickedState(await player, await task);
    }
    if (event is SpinStarted) {
      yield SpinInProgressState("Yeeeha!");
    }
  }
}
