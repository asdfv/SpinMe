import 'package:domain/domain_module.dart';
import 'package:equatable/equatable.dart';

abstract class WheelState extends Equatable {}

class InitialState extends WheelState {
  final String label;

  InitialState(this.label);

  @override
  List<Object?> get props => [label];
}

class SpinInProgressState extends WheelState {
  final String label;

  SpinInProgressState(this.label);

  @override
  List<Object?> get props => [label];
}

class PlayerPickedState extends WheelState {
  final Player player;
  final Task task;

  PlayerPickedState(this.player, this.task);

  @override
  List<Object?> get props => [player, task];
}
