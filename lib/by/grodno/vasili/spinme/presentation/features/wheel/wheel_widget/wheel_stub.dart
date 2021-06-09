import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'wheel_widget_contract.dart';

/// Stub for wheel for development needs.
class WheelStub extends WheelWidgetContract {
  final List<WheelItem> items;
  final Function onSpinStarted;
  final Function(WheelItem) onSpinFinished;
  static _doNothing() => (){};

  WheelStub({
    required this.items,
    this.onSpinStarted = _doNothing,
    required this.onSpinFinished,
  }) : super(items: items, onSpinStarted: onSpinStarted, onSpinFinished: onSpinFinished);

  @override
  State<StatefulWidget> createState() => _WheelStubState();
}

class _WheelStubState extends State<WheelStub> {
  var title = "Spin me";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                setState(() {
                  title = "Spinning...";
                });
                widget.onSpinStarted();
                await Future.delayed(Duration(milliseconds: 750), () {});
                widget.onSpinFinished(widget.items[Random().nextInt(widget.items.length)]);
                setState(() {
                  title = "Spin me";
                });
              },
              child: Text("Click me")),
          SizedBox(
            width: 200,
            height: 200,
            child: Container(
                decoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.cyan),
                child: Center(child: Text(title))),
          ),
        ],
      ),
    );
  }
}
