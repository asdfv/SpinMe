import 'package:domain/domain_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/bloc/wheel_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/bloc/wheel_event.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/bloc/wheel_state.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/utilities/utilities.dart';

import 'wheel_widget/flutter_fortune_wheel.dart';
import 'wheel_widget/wheel_widget_contract.dart';

class WheelScaffold extends StatefulWidget {
  @override
  _WheelScaffoldState createState() => _WheelScaffoldState();
}

class _WheelScaffoldState extends State<WheelScaffold> {
  late WheelBloc _bloc;
  final log = getLogger();

  @override
  void initState() {
    _bloc = context.read<WheelBloc>()..add(ConfigureWheel());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WheelBloc, WheelState>(builder: (context, state) => _buildScaffold(context, state));
  }

  Widget _buildScaffold(BuildContext context, WheelState state) {
    log.i(message: "WheelState changed. WheelState: $state");
    final String label = _getLabel(state.label);
    final List<WheelItem>? items = state.items;
    final Player? pickedPlayer = state.pickedPlayer;

    if (state.gameOver) Future.delayed(Duration.zero, () => _showGameOverDialog(context));

    final Task? pickedTask = state.pickedTask;
    final topLabelText = pickedTask == null ? "" : context.getLocalizedString("wheel_what") + pickedTask.description;
    final bottomLabelText = pickedPlayer == null ? "" : context.getLocalizedString("wheel_who") + pickedPlayer.name;
    final body = items == null
        ? Center(child: CircularProgressIndicator())
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 100,
                child: Align(
                    alignment: Alignment.center,
                    child: Text(topLabelText, maxLines: 1, overflow: TextOverflow.ellipsis)),
              ),
              Expanded(
                child: FlutterFortuneWheel(
                  items: items,
                  onSpinFinished: (item) {
                    _bloc.add(SpinFinished(item));
                  },
                  onSpinStarted: () {
                    _bloc.add(SpinStarted());
                  },
                ),
              ),
              SizedBox(
                height: 100,
                child: Align(
                    alignment: Alignment.center,
                    child: Text(bottomLabelText, maxLines: 1, overflow: TextOverflow.ellipsis)),
              ),
            ],
          );

    return WillPopScope(
      onWillPop: () => _showExitDialog(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        body: body,
      ),
    );
  }

  String _getLabel(SpinLabel label) {
    switch (label) {
      case SpinLabel.initial:
        return context.getLocalizedString("wheel_spin_initial_label");
      case SpinLabel.spinning:
        return context.getLocalizedString("wheel_spin_spinning_label");
      case SpinLabel.finished:
        return context.getLocalizedString("wheel_spin_finished_label");
    }
  }

  Future<bool> _showExitDialog(BuildContext context) => showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
            title: Text(context.getLocalizedString("wheel_exit_title")),
            content: Text(context.getLocalizedString("wheel_exit_content")),
            actions: <Widget>[
              ElevatedButton(
                child: Text(context.getLocalizedString("app_ok")),
                onPressed: () => Navigator.of(context).pop(true),
              ),
              ElevatedButton(
                child: Text(context.getLocalizedString("app_cancel")),
                onPressed: () => Navigator.of(context).pop(false),
              )
            ],
          )).then((value) => value ?? true);

  // todo implement logic https://trello.com/c/8E4jlruH
  void _showGameOverDialog(BuildContext context) => showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
            title: Text("Game over guys"),
            content: Text("💁"),
            actions: <Widget>[
              ElevatedButton(
                child: Text("Okay"),
                onPressed: () => Navigator.of(context).pop(true),
              )
            ],
          )).then((value) => value ?? true);
}
