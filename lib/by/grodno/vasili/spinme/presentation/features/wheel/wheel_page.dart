import 'package:domain/domain_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/bloc/wheel_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/bloc/wheel_event.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/bloc/wheel_state.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/main.dart';

import 'wheel_widget/flutter_fortune_wheel.dart';
import 'wheel_widget/wheel_widget_contract.dart';

const routeWheel = "/wheel";

/// Page with the wheel which can be rotated and can pick the task and the person to do the task.
class WheelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coordinator = WheelCoordinator(getIt<TasksRepository>(), getIt<PlayersRepository>());
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
    final String label = state.label;
    final List<WheelItem>? items = state.items;
    final Player? pickedPlayer = state.pickedPlayer;
    final Task? pickedTask = state.pickedTask;
    final topLabelText = pickedTask == null ? "" : "What: ${pickedTask.description}";
    final bottomLabelText = pickedPlayer == null ? "" : "Who: ${pickedPlayer.name}";
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

  Future<bool> _showExitDialog(BuildContext context) => showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
            title: const Text("Do you really want to exit?"),
            content: const Text("All the progress will be lost."),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Yes'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
              ElevatedButton(
                child: const Text('No'),
                onPressed: () => Navigator.of(context).pop(false),
              )
            ],
          )).then((value) => value ?? true);
}
