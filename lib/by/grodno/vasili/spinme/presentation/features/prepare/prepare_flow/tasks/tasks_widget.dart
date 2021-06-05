import 'package:domain/domain_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_state.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/preferences/game_preferences.dart';
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
                _onNext(tasks);
              },
              child: Text("Let's play!"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _onShare(tasks);
              },
              child: Text("Share your tasks"),
            ),
          ),
        ],
      );

  void _onNext(List<Task> tasks) {
    final Set<Task> changedTasks = _changedTasksIds.entries.map((entry) {
      final task = tasks.firstWhere((element) => element.id == entry.key);
      return task.copyWith(isChecked: entry.value);
    }).toSet();
    final Set<Task> updatedTasks = Set.from(changedTasks)..addAll(tasks);
    final checkedTasks = updatedTasks.where((element) => element.isChecked).toList();
    final checkedTasksIds = checkedTasks.map((e) => e.id).toList();
    final minimumNumberTasks = GamePreferences.minTasksToPlay;
    if (checkedTasksIds.length > minimumNumberTasks) {
      log.i(message: "Chosen tasks ids: $checkedTasksIds");
      widget.onTasksChosen(checkedTasks);
    } else {
      context.snack("Please chose more that $minimumNumberTasks");
    }
  }

  void _onShare(List<Task> tasks) {
    final tasksDescriptions = tasks.map((e) => e.description).join("\n");
    log.d(message: "Share tasks: $tasksDescriptions");
    Share.share(tasksDescriptions);
  }
}