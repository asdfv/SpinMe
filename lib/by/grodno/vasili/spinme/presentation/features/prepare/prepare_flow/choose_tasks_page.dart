import 'package:domain/domain_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_state.dart';

const routeChooseTasks = "chooseTasks";

class ChooseTasksPage extends StatelessWidget {
  const ChooseTasksPage({
    Key? key,
    required this.onTasksChosen,
  }) : super(key: key);

  final Function(List<int>) onTasksChosen;

  @override
  Widget build(BuildContext context) => TasksWidget();
}

class TasksWidget extends StatefulWidget {
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
          return ListView.builder(
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
              });
        } else if (state is TaskLoadErrorState) {
          return Center(child: Text(state.message));
        } else {
          throw UnimplementedError("Unknown state on Prepare screen.");
        }
      },
    );
  }
}

class CheckableTaskItem extends StatefulWidget {
  final Task task;
  final bool isChecked;
  final Function(bool) onCheck;

  const CheckableTaskItem({
    Key? key,
    required this.task,
    required this.isChecked,
    required this.onCheck,
  }) : super(key: key);

  @override
  _CheckableTaskItemState createState() => _CheckableTaskItemState();
}

class _CheckableTaskItemState extends State<CheckableTaskItem> {
  late bool isChecked;

  @override
  void initState() {
    isChecked = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.task.description),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
        widget.onCheck(value!);
      },
    );
  }
}
