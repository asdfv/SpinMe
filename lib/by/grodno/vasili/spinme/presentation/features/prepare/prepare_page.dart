import 'package:domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_event.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_state.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/prepare_flow/players/choose_players_page.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/prepare_flow/tasks/choose_tasks_page.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/welcome/welcome_page.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/wheel/wheel_page.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/main.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/spin_me_app.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/utilities/utilities.dart';

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
  late PrepareBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PrepareBloc(PrepareState(isLoading: true), getIt<PrepareCoordinator>()),
      child: Builder(
        builder: (context) {
          _bloc = context.read<PrepareBloc>();
          return Scaffold(
            appBar: AppBar(
              title: Text(context.getLocalizedString('prepare_setting_up')),
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
    _bloc.add(NamesChosen(names));
    _prepareNavigatorKey.currentState!.pushNamed(routeChooseTasks);
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case routeChoosePlayers:
        _bloc.add(LoadPlayers());
        page = ChoosePlayersPage(onPlayersChosen: _onPlayersChosen);
        break;
      case routeChooseTasks:
        _bloc.add(LoadTasks());
        page = ChooseTasksPage(
          onTasksChosen: (List<Task> tasks) {
            _bloc.add(TasksChosen(tasks));
            mainNavigatorKey.currentState!
                .pushNamedAndRemoveUntil(routeWheel, (route) => route.settings.name == routeWelcome);
          },
          onTaskEdit: (oldTask, newTask) {
            _bloc.add(TaskEdited(oldTask, newTask));
          },
          onTaskAdded: (task) {
            _bloc.add(TaskAdded(task));
          },
          onTaskDelete: (id) {
            _bloc.add(DeleteTask(id));
          },
        );
        break;
      default:
        page = Scaffold(
          body: Text("Wrong route: ${settings.name}"),
        );
    }
    return MaterialPageRoute<dynamic>(
      builder: (_) => page,
      settings: settings,
    );
  }
}
