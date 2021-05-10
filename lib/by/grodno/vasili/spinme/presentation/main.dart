import 'package:data/data_module.dart';
import 'package:domain/domain_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/prepare_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/prepare_event.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/prepare_state.dart';

import 'features/bloc/simple_bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coordinator = PrepareCoordinator(FakeTasksRepository());
    return BlocProvider(
      create: (BuildContext _) => PrepareBloc(TasksLoadingState(), coordinator)..add(LoadTasks()),
      child: MaterialApp(
        title: "My app",
        home: TasksPage(),
      ),
    );
  }
}

class TasksPage extends StatelessWidget {
  const TasksPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PrepareBloc, PrepareState>(
        builder: (context, state) {
          if (state is TasksLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TasksLoadedState) {
            final tasks = state.tasks;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) => ListTile(
                leading: Icon(Icons.stream),
                title: Text(tasks[index]),
              ),
            );
          } else if (state is TaskLoadErrorState) {
            return Center(child: Text(state.message));
          } else {
            throw UnimplementedError("Unknown state on Prepare screen.");
          }
        },
      ),
    );
  }
}
