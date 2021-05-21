import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class WheelWidgetContract extends StatefulWidget {
  final List<WheelItem> items;
  final Function(WheelItem) onSpinFinished;

  const WheelWidgetContract({Key? key, required this.items, required this.onSpinFinished}) : super(key: key);
}

class WheelItem extends Equatable {
  final int index;
  final String label;

  WheelItem({required this.index, required this.label});

  @override
  List<Object?> get props => [index, label];
}
