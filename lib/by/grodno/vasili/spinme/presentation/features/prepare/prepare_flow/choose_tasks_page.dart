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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("ChooseTasksPage"),
          ElevatedButton(
            onPressed: () {
              onTasksChosen([1, 2, 3]);
            },
            child: Text("Show me the wheel!"),
          )
        ],
      ),
    );
  }
}

// class TaskItem extends StatelessWidget {
//   final Function(int) onChanged;
//   final Task
//
//   const TaskItem({Key? key, required this.onChanged}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         onChanged(!value);
//       },
//       child: Padding(
//         padding: padding,
//         child: Row(
//           children: <Widget>[
//             Expanded(child: Text(label)),
//             Checkbox(
//               value: value,
//               onChanged: (bool? newValue) {
//                 onChanged(newValue);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// todo use add this later
class TasksWidget extends StatelessWidget {
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
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.stream),
              title: Text(tasks[index].description),
            ),
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
