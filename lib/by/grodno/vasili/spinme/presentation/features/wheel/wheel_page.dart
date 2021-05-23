import 'package:data/data_module.dart';
import 'package:domain/domain_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/bloc/wheel_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/bloc/wheel_event.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/bloc/wheel_state.dart';

import 'wheel_widget/flutter_fortune_wheel.dart';
import 'wheel_widget/wheel_widget_contract.dart';

const routeWheel = "/wheel";

class WheelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coordinator = WheelCoordinator(FakeTasksRepository());
    return BlocProvider(
      create: (_) => WheelBloc(coordinator),
      child: WheelPageScaffold(),
    );
  }
}

class WheelPageScaffold extends StatefulWidget {
  @override
  _WheelPageScaffoldState createState() => _WheelPageScaffoldState();
}

class _WheelPageScaffoldState extends State<WheelPageScaffold> {
  final items = [
    WheelItem(index: 0, label: "Zero item"),
    WheelItem(index: 1, label: "One item"),
    WheelItem(index: 2, label: "Two item"),
    WheelItem(index: 3, label: "Three item"),
    WheelItem(index: 4, label: "Four item"),
    WheelItem(index: 5, label: "Five item"),
    WheelItem(index: 6, label: "Six item"),
    WheelItem(index: 7, label: "Seven item"),
    WheelItem(index: 8, label: "Eight item"),
  ];

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WheelBloc>();
    return BlocBuilder<WheelBloc, WheelState>(
      builder: (context, state) {
        final String title;
        if (state is PersonPickedState) {
          title = state.person;
        } else if (state is InitialState) {
          title = state.label;
        } else if (state is SpinInProgressState) {
          title = state.label;
        } else {
          title = "";
        }
        return WillPopScope(
          onWillPop: () => _showExitDialog(context),
          child: Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: FlutterFortuneWheel(
              items: items,
              onSpinFinished: (item) {
                bloc.add(SpinFinished(item));
              },
              onSpinStarted: () {
                bloc.add(SpinStarted());
              },
            ),
          ),
        );
      },
    );
  }

  Future<bool> _showExitDialog(BuildContext context) => showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
            title: Text("Do you really want to exit?"),
            content: Text("All the progress will be lost."),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Yes'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
              ElevatedButton(
                child: Text('No'),
                onPressed: () => Navigator.of(context).pop(false),
              )
            ],
          )).then((value) => value ?? true);
}
