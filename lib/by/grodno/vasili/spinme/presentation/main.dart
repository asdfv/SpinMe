import 'package:data/data_module.dart';
import 'package:domain/domain_module.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/utilities/key_generator.dart';

import 'spin_me_app.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await startDataLayer(appDocumentDir.path);
  setupGetIt();
  // Bloc.observer = SimpleBlocObserver();
  EquatableConfig.stringify = true;
  runApp(SpinMeApp());
}

/// Setup GetIt dependencies.
void setupGetIt() {
  final tasksRepository = TasksDataRepository(HiveTasksDatasource());
  final playersRepository = PlayersDataRepository(HivePlayersDatasource());
  getIt.registerSingleton<Settings>(Settings(AppSettingsRepository()), signalsReady: true);
  getIt
      .registerFactory<WheelCoordinator>(() => WheelCoordinator(tasksRepository, playersRepository, getIt<Settings>()));
  getIt.registerSingleton<PrepareCoordinator>(PrepareCoordinator(tasksRepository, playersRepository),
      signalsReady: true);
  getIt.registerFactory<KeyGenerator>(() => IncreasingNumbersKeyGenerator());
  getIt.registerSingleton<WelcomeCoordinator>(WelcomeCoordinator(getIt<Settings>()), signalsReady: true);
}
