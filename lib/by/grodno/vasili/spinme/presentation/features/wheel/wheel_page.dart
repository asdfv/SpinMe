import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/wheel_widget.dart';

const wheelRoute = "/wheel";

class WheelPage extends StatefulWidget {
  @override
  _WheelPageState createState() => _WheelPageState();
}

class _WheelPageState extends State<WheelPage> {
  var title = "";

  @override
  Widget build(BuildContext context) {
    final items = [
      WheelItem(index: 0, label: "Zero item"),
      WheelItem(index: 1, label: "One item"),
      WheelItem(index: 2, label: "Two item"),
      WheelItem(index: 3, label: "Three item"),
      WheelItem(index: 4, label: "Four item"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FlutterFortuneWheel(
        items: items,
        onSpinFinished: (item) {
          setState(() {
            title = item.label;
          });
        },
      ),
    );
  }
}
