import 'package:domain/domain_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/bloc/wheel_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/main.dart';

import 'wheel_scaffold.dart';

const routeWheel = "/wheel";

/// Page with the wheel which can be rotated and can pick the task and the person to do the task.
class WheelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WheelBloc(getIt<WheelCoordinator>()),
      child: WheelScaffold(),
    );
  }
}

