import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/wheel_widget/wheel_widget_contract.dart';

@immutable
abstract class WheelEvent extends Equatable {}

class ConfigureWheel extends WheelEvent {
  @override
  List<Object?> get props => [];
}

class SpinStarted extends WheelEvent {
  @override
  List<Object?> get props => [];
}

class SpinFinished extends WheelEvent {
  final WheelItem item;

  SpinFinished(this.item);

  @override
  List<Object?> get props => [item];
}
