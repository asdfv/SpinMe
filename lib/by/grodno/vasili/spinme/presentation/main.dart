import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/wheel_page.dart';

import 'bloc/simple_bloc_observer.dart';
import 'navigation/router_generator.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My app",
      initialRoute: wheelRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
