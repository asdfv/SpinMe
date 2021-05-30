import 'package:domain/domain_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_state.dart';

import 'checkable_task_item.dart';

const routeChooseTasks = "chooseTasks";

class ChooseTasksPage extends StatelessWidget {
  const ChooseTasksPage({
    Key? key,
    required this.onTasksChosen,
  }) : super(key: key);

  final Function(List<Task>) onTasksChosen;

  @override
  Widget build(BuildContext context) => TasksWidget(onTasksChosen: onTasksChosen);
}

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key? key, required this.onTasksChosen}) : super(key: key);

  final Function(List<Task>) onTasksChosen;

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  Map<int, bool> checkableTaskIds = {};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrepareBloc, PrepareState>(
      builder: (context, state) {
        if (state is TasksLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TasksLoadedState) {
          final tasks = state.tasks;
          checkableTaskIds = {for (final task in tasks) task.id: true};
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      var task = tasks[index];
                      return CheckableTaskItem(
                        task: task,
                        isChecked: checkableTaskIds[task.id]!,
                        onCheck: (isChecked) {
                          checkableTaskIds[task.id] = isChecked;
                        },
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    final checkedIds =
                        checkableTaskIds.entries.where((element) => element.value).map((e) => e.key).toList();
                    final checkedTasks = tasks.where((element) => checkedIds.contains(element.id)).toList();
                    widget.onTasksChosen(checkedTasks);
                  },
                  child: Text("Let's play!"),
                ),
              )
            ],
          );
        } else if (state is TaskLoadErrorState) {
          return Center(child: Text(state.message));
        } else {
          throw UnimplementedError("Unknown state on Prepare screen.");
        }
      },
    );
  }
}
