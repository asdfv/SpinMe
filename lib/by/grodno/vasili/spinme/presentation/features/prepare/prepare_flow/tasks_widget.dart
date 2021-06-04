import 'package:domain/domain_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_state.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/utilities/utilities.dart';

import 'checkable_task_item.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({
    Key? key,
    required this.onTasksChosen,
    required this.onTaskEdited,
    required this.onTaskDelete,
  }) : super(key: key);

  final Function(List<Task>) onTasksChosen;
  final Function(Task, Task) onTaskEdited;
  final Function(int) onTaskDelete;

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
        final tasks = state.tasks;
        final isLoading = state.isLoading;

        if (isLoading) return Center(child: CircularProgressIndicator());
        return tasks == null ? Center(child: Text("Whoops! Strange state o_O")) : _buildTasksList(tasks);
      },
    );
  }

  Widget _buildTasksList(List<Task> tasks) => Column(
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
                    onEdit: (String newText) {
                      widget.onTaskEdited(task, task.copyWith(description: newText));
                    },
                    onDelete: () {
                      widget.onTaskDelete(task.id);
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

  void _onNextClicked(List<Task> tasks) {
    final Set<Task> changedTasks = _changedTasksIds.entries.map((entry) {
      final task = tasks.firstWhere((element) => element.id == entry.key);
      return task.copyWith(isChecked: entry.value);
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
