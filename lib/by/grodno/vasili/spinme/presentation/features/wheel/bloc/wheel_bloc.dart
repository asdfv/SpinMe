import 'package:domain/domain_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/bloc/wheel_event.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/bloc/wheel_state.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/wheel_widget/wheel_widget_contract.dart';

/// [Bloc] for reducing events on wheel screen to UI states.
class WheelBloc extends Bloc<WheelEvent, WheelState> {
  WheelBloc(this.coordinator) : super(WheelState(label: "Spin the wheel!"));

  final WheelCoordinator coordinator;

  @override
  Stream<WheelState> mapEventToState(WheelEvent event) async* {
    if (event is SpinFinished) yield* _mapSpinFinished(event);
    else if (event is SpinStarted) yield state.copyWith(label: "Yeeeha!");
    else if (event is ConfigureWheel) yield* _mapConfigureWheel(event);
    else throw UnimplementedError("Unknown wheel-event: $event");
  }

  Stream<WheelState> _mapSpinFinished(SpinFinished event) async* {
    final task = coordinator.pickTask();
    final player = coordinator.pickPlayer(event.item.id);
    yield state.copyWith(
      label: "${(await player).name} do the task!",
      pickedPlayer: await player,
      pickedTask: await task,
    );
  }

  Stream<WheelState> _mapConfigureWheel(ConfigureWheel event) async* {
    final players = await coordinator.getChosenPlayers();
    final items = players.map((e) => WheelItem(id: e.id, label: e.name)).toList();
    yield state.copyWith(items: items);
  }
}
