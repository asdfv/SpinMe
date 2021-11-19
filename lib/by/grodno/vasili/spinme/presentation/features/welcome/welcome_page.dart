import 'package:domain/domain_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/welcome/bloc/welcome_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/main.dart';

import 'welcome_scaffold.dart';

const routeWelcome = "/";

/// The very first page with an invitation to play.
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WelcomeBloc(getIt<WelcomeCoordinator>()),
      child: WelcomeScaffold(),
    );
  }
}
