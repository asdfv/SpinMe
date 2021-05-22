import 'package:flutter/material.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/prepare_page.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/welcome/welcome_page.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/wheel_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => WelcomePage());
      case wheelRoute:
        return MaterialPageRoute(builder: (_) => WheelPage());
      case preparePageRoute:
        return MaterialPageRoute(builder: (_) => PreparePage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(body: Center(child: Text('No route defined for ${settings.name}'))));
    }
  }
}
