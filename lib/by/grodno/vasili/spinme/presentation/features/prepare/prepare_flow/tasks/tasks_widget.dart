import 'dart:math';

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
import 'package:spinme/by/grodno/vasili/spinme/presentation/widgets/text_dialog.dart';

import 'checkable_task_item.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({
    Key? key,
    required this.onTasksChosen,
    required this.onTaskEdited,
    required this.onTaskAdded,
    required this.onTaskDelete,
  }) : super(key: key);

  final Function(List<Task>) onTasksChosen;
  final Function(Task, Task) onTaskEdited;
  final Function(Task) onTaskAdded;
  final Function(int) onTaskDelete;

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  final log = getLogger();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrepareBloc, PrepareState>(
      builder: (context, state) {
        final tasks = state.tasks;
        final isLoading = state.isLoading;
        const loadingWidget = const Center(child: CircularProgressIndicator());
        if (isLoading) return loadingWidget;
        return tasks == null ? loadingWidget : _buildTasksList(tasks);
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
                    key: ValueKey(task),
                    task: task,
                    onCheck: (isChecked) {
                      widget.onTaskEdited(task, task.copyWith(isChecked: isChecked));
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
              child: Text(context.getLocalizedString("prepare_tasks_lets_play")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              key: ValueKey("tasks_widget_add_task_button"),
              onPressed: () async {
                final description = await _showAddTaskDialog(context);
                if (description == null) return;
                var minCharacters = GameConstants.minCharactersInTaskDescription;
                if (description.trim().length < minCharacters) {
                  final message = context.getLocalizedString("prepare_tasks_short_description_message", minCharacters);
                  context.info(message);
                  return;
                }
                widget.onTaskAdded(Task(
                  Random().nextInt(1 << 32),
                  description,
                  true,
                ));
              },
              child: Text(context.getLocalizedString("prepare_tasks_add_tasks")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _onShare(tasks);
              },
              child: Text(context.getLocalizedString("prepare_tasks_share")),
            ),
          ),
        ],
      );

  void _onNext(List<Task> tasks) {
    final minimumNumberTasks = GameConstants.minTasksToPlay;
    var checkedTasks = tasks.where((element) => element.isChecked);
    var numberOfCheckedTasks = checkedTasks.length;
    if (numberOfCheckedTasks >= minimumNumberTasks) {
      log.i(message: "Tasks chosen: $checkedTasks");
      widget.onTasksChosen(tasks);
    } else {
      final tasksLeft = minimumNumberTasks - numberOfCheckedTasks;
      context.info(context.getLocalizedString("prepare_tasks_short_not_enough_tasks_message", tasksLeft));
    }
  }

  void _onShare(List<Task> tasks) {
    final tasksDescriptions = tasks.map((e) => e.description).join("\n");
    log.d(message: "Share tasks: $tasksDescriptions");
    Share.share(tasksDescriptions);
  }

  Future<String?> _showAddTaskDialog(BuildContext context) async => await showDialog<String?>(
      context: context,
      builder: (dialogContext) => TextDialog(
            context: dialogContext,
            titleLabel: context.getLocalizedString("prepare_tasks_add_new_task"),
            okLabel: context.getLocalizedString("app_add"),
            cancelLabel: context.getLocalizedString("app_cancel"),
          ));
}
