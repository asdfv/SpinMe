import 'package:flutter/material.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/prepare_page.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/welcome/welcome_page.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/wheel_page.dart';

/// Main routing.
class MainRouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    late Widget page;
    if (settings.name == routeWelcome) {
      page = WelcomePage();
    } else if (settings.name == routeWheel) {
      page = WheelPage();
    } else if (settings.name!.startsWith(routePreparePage)) {
      final subRoute = settings.name!.substring(routePreparePage.length);
      page = PreparePage(preparePageRoute: subRoute);
    } else {
      page = Scaffold(body: Center(child: Text('No route defined for ${settings.name}')));
    }
    return MaterialPageRoute<dynamic>(
      builder: (_) => page,
      settings: settings,
    );
  }
}
