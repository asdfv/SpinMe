import 'package:data/data_module.dart';
import 'package:domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_state.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/prepare_flow/choose_players_page.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/prepare_flow/choose_tasks_page.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/welcome/welcome_page.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/wheel_page.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/main.dart';

const routePreparePage = "/prepare/";
const routePreparePageFirstPage = "/prepare/$routeChoosePlayers";

class PreparePage extends StatefulWidget {
  const PreparePage({Key? key, required this.preparePageRoute}) : super(key: key);

  final String preparePageRoute;

  @override
  _PreparePageState createState() => _PreparePageState();
}

class _PreparePageState extends State<PreparePage> {
  final _prepareNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final coordinator = PrepareCoordinator(FakeTasksRepository());
    return BlocProvider(
      create: (_) => PrepareBloc(TasksLoadingState(), coordinator),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Prepare page"),
        ),
        body: Navigator(
          key: _prepareNavigatorKey,
          initialRoute: widget.preparePageRoute,
          onGenerateRoute: _onGenerateRoute,
        ),
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case routeChoosePlayers:
        page = ChoosePlayersPage(
          onPlayersChosen: () {
            _prepareNavigatorKey.currentState!.pushNamed(routeChooseTasks);
          },
        );
        break;
      case routeChooseTasks:
        page = ChooseTasksPage(
          onTasksChosen: () {
            mainNavigatorKey.currentState!
                .pushNamedAndRemoveUntil(routeWheel, (route) => route.settings.name == routeWelcome);
          },
        );
        break;
      default:
        page = Scaffold(
          body: Text("Wrong route: ${settings.name}"),
        );
    }
    return MaterialPageRoute<dynamic>(
      builder: (context) => page,
      settings: settings,
    );
  }
}
