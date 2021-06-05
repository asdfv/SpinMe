import 'package:data/data_module.dart';
import 'package:domain/domain_module.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/welcome/welcome_page.dart';

import 'navigation/main_router_generator.dart';

GetIt getIt = GetIt.instance;

void main() {
  setupGetIt();
  // Bloc.observer = SimpleBlocObserver();
  EquatableConfig.stringify = true;
  runApp(MyApp());
}

final mainNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SpinMe",
      initialRoute: routeWelcome,
      navigatorKey: mainNavigatorKey,
      onGenerateRoute: MainRouteGenerator.generateRoute,
    );
  }
}

void setupGetIt() {
  getIt.registerSingleton<TasksRepository>(FakeTasksRepository(), signalsReady: true);
  getIt.registerSingleton<PlayersRepository>(FakePlayersRepository(), signalsReady: true);
}
