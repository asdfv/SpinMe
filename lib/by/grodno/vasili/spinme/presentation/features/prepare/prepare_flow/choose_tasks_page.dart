import 'package:domain/domain_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'tasks_widget.dart';

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
