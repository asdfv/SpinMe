import 'package:equatable/equatable.dart';

abstract class WheelState extends Equatable {}

class InitialState extends WheelState {
  final String label;

  InitialState(this.label);

  @override
  List<Object?> get props => [label];
}

class PersonPickedState extends WheelState {
  final String person;
  final String task;

  PersonPickedState(this.person, this.task);

  @override
  List<Object?> get props => [person, task];
}
