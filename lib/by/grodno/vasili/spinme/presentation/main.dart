import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/welcome/welcome_page.dart';

import 'bloc/simple_bloc_observer.dart';
import 'navigation/main_router_generator.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
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
