import 'package:domain/domain_module.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/wheel_widget/wheel_widget_contract.dart';

@immutable
class WheelState extends Equatable {
  WheelState({this.label = "", this.items, this.pickedPlayer, this.pickedTask});

  final String label;
  final List<WheelItem>? items;
  final Player? pickedPlayer;
  final Task? pickedTask;

  WheelState copyWith({label, items, pickedPlayer, pickedTask}) => WheelState(
        label: label ?? this.label,
        items: items ?? this.items,
        pickedPlayer: pickedPlayer ?? this.pickedPlayer,
        pickedTask: pickedTask ?? this.pickedTask,
      );

  @override
  String toString() => "[label: $label, items: $items, pickedPlayer: $pickedPlayer, pickedTask: $pickedTask]";

  @override
  List<Object?> get props => [label, items, pickedPlayer?.id, pickedTask?.id];
}
