import 'package:data/data_module.dart';
import 'package:domain/domain_module.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/welcome/welcome_page.dart';

import 'navigation/main_router_generator.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await initDataLayer(appDocumentDir.path);
  setupGetIt();
  // Bloc.observer = SimpleBlocObserver();
  EquatableConfig.stringify = true;
  runApp(MyApp());
}

final mainNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SpinMe",
      initialRoute: routeWelcome,
      navigatorKey: mainNavigatorKey,
      onGenerateRoute: MainRouteGenerator.generateRoute,
    );
  }

  @override
  void dispose() {
    stopDataLayer();
    super.dispose();
  }
}

void setupGetIt() {
  getIt.registerSingleton<TasksRepository>(TasksDataRepository(HiveTasksDatasource()), signalsReady: true);
  getIt.registerSingleton<PlayersRepository>(PlayersDataRepository(HivePlayersDatasource()), signalsReady: true);
}
