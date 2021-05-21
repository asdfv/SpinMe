import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/widget/wheel_widget.dart';

@immutable
abstract class WheelEvent extends Equatable {}

class SpinFinished extends WheelEvent {
  final WheelItem item;

  SpinFinished(this.item);

  @override
  List<Object?> get props => [item];
}
