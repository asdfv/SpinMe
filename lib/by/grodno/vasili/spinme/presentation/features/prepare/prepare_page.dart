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

import 'bloc/prepare_event.dart';

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
  PrepareBloc? _bloc;

  @override
  Widget build(BuildContext context) {
    final coordinator = PrepareCoordinator(getIt<TasksRepository>(), getIt<PlayersRepository>());
    return BlocProvider(
      create: (_) => PrepareBloc(TasksLoadingState(), coordinator),
      child: Builder(
        builder: (context) {
          _bloc = context.read<PrepareBloc>();
          return Scaffold(
            appBar: AppBar(
              title: Text("Setting up the Game"),
            ),
            body: Navigator(
              key: _prepareNavigatorKey,
              initialRoute: widget.preparePageRoute,
              onGenerateRoute: _onGenerateRoute,
            ),
          );
        },
      ),
    );
  }

  void _onPlayersChosen(List<String> names) {
    _bloc!.add(NamesChosen(names));
    _prepareNavigatorKey.currentState!.pushNamed(routeChooseTasks);
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case routeChoosePlayers:
        page = ChoosePlayersPage(onPlayersChosen: _onPlayersChosen);
        break;
      case routeChooseTasks:
        page = ChooseTasksPage(
          onTasksChosen: (List<int> tasksIds) {
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
