import 'package:domain/domain_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/utilities/utilities.dart';

import 'tasks_widget.dart';

const routeChooseTasks = "chooseTasks";

/// Page where the user can edit, add and mark tasks to play.
class ChooseTasksPage extends StatelessWidget {
  const ChooseTasksPage({
    Key? key,
    required this.onTasksChosen,
    required this.onTaskEdit,
    required this.onTaskAdded,
    required this.onTaskDelete,
  }) : super(key: key);

  final Function(List<Task>) onTasksChosen;
  final Function(Task, Task) onTaskEdit;
  final Function(Task) onTaskAdded;
  final Function(int) onTaskDelete;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 24),
          Text(context.getLocalizedString("prepare_tasks_choose_tasks")),
          Expanded(
              child: TasksWidget(
            onTasksChosen: onTasksChosen,
            onTaskEdited: onTaskEdit,
            onTaskAdded: onTaskAdded,
            onTaskDelete: onTaskDelete,
          )),
        ],
      );
}
