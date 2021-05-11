import 'package:data/data_module.dart';
import 'package:domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_state.dart';

import 'bloc/prepare_event.dart';

const preparePageRoute = "/prepare";

class PreparePage extends StatelessWidget {
  const PreparePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final coordinator = PrepareCoordinator(FakeTasksRepository());
    return BlocProvider(
      create: (BuildContext _) => PrepareBloc(TasksLoadingState(), coordinator)..add(LoadTasks()),
      child: PrepareScaffold(),
    );
  }
}

class PrepareScaffold extends StatelessWidget {
  const PrepareScaffold({
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
