import 'package:domain/domain_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'tasks_widget.dart';

const routeChooseTasks = "chooseTasks";

class ChooseTasksPage extends StatelessWidget {
  const ChooseTasksPage({
    Key? key,
    required this.onTasksChosen,
    required this.onTaskEdit,
    required this.onTaskDelete,
  }) : super(key: key);

  final Function(List<Task>) onTasksChosen;
  final Function(Task, Task) onTaskEdit;
  final Function(int) onTaskDelete;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 24),
          const Text("Chose tasks that you want to play"),
          Expanded(
              child: TasksWidget(
            onTasksChosen: onTasksChosen,
            onTaskEdited: onTaskEdit,
            onTaskDelete: onTaskDelete,
          )),
        ],
      );
}
