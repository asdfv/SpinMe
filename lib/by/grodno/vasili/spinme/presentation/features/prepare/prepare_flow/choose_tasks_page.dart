import 'package:domain/domain_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_state.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/utilities/converters.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/utilities/utilities.dart';

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
  final log = getLogger();
  final Map<int, bool> _changedTasksIds = {};

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
                        isChecked: task.isChecked,
                        onCheck: (isChecked) {
                          _changedTasksIds[task.id] = isChecked;
                        },
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _onNextClicked(tasks);
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

  void _onNextClicked(List<Task> tasks) {
    final Set<Task> changedTasks = _changedTasksIds.entries.map((e) {
      final task = tasks.firstWhere((element) => element.id == e.key);
      return task.copyWithCheck(e.value);
    }).toSet();
    final Set<Task> updatedTasks = Set.from(changedTasks)..addAll(tasks);
    final checkedTasksIds = updatedTasks.where((element) => element.isChecked).map((e) => e.id).toList();
    log.i(message: "Chosen tasks ids: $checkedTasksIds");
    final minimumNumberTasks = 3;
    if (checkedTasksIds.length > minimumNumberTasks) {
      widget.onTasksChosen(updatedTasks.toList());
    } else {
      context.snack("Please chose more that $minimumNumberTasks");
    }
  }
}
