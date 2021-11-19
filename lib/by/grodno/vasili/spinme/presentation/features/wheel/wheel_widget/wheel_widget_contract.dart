import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

/// Contract to support for wheel.
abstract class WheelWidgetContract extends StatefulWidget {
  final List<WheelItem> items;
  final Function onSpinStarted ;
  final Function(WheelItem) onSpinFinished;
  static _doNothing() => (){};

  const WheelWidgetContract({
    Key? key,
    required this.items,
    required this.onSpinFinished,
    this.onSpinStarted = _doNothing,
  }) : super(key: key);

}

class WheelItem extends Equatable {
  final int id;
  final String label;

  WheelItem({required this.id, required this.label});

  @override
  List<Object?> get props => [id, label];
}
