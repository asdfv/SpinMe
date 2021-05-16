import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

abstract class WheelWidget extends StatefulWidget {
  final List<WheelItem> items;
  final Function(WheelItem) onSpinFinished;

  const WheelWidget({Key? key, required this.items, required this.onSpinFinished}) : super(key: key);
}

class WheelItem {
  final int index;
  final String label;

  WheelItem({required this.index, required this.label});
}

class FlutterFortuneWheel extends WheelWidget {
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
