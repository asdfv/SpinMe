import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

import 'wheel_widget.dart';

class FlutterFortuneWheel extends WheelWidgetContract {
  final List<WheelItem> items;
  final Function(WheelItem) onSpinFinished;

  FlutterFortuneWheel({
    required this.items,
    required this.onSpinFinished,
  }) : super(items: items, onSpinFinished: onSpinFinished);

  @override
  State<StatefulWidget> createState() => _FlutterFortuneWheelState();
}

class _FlutterFortuneWheelState extends State<FlutterFortuneWheel> {
  final controller = StreamController<int>();
  var nextNumber = -1;

  @override
  Widget build(BuildContext context) {
    final items = widget.items.map((wheelItem) => FortuneItem(child: Text(wheelItem.label))).toList();
    return FortuneWheel(
      animateFirst: false,
      physics: CircularPanPhysics(
        duration: Duration(milliseconds: 500),
        curve: Curves.decelerate,
      ),
      onFling: () {
        nextNumber = Fortune.randomInt(0, items.length);
        controller.add(nextNumber);
      },
      selected: controller.stream,
      items: items,
      onAnimationEnd: () {
        widget.onSpinFinished(widget.items[nextNumber]);
      },
    );
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }
}
