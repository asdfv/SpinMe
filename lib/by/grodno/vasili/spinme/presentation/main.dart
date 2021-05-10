import 'package:data/data_module.dart';
import 'package:domain/domain_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tasks = PrepareCoordinator(DefaultTasksRepository()).getAllTasks();
    return MaterialApp(
      title: "My app",
      home: Scaffold(
        body: Center(
          child: Text("Tasks count: ${tasks.length}"),
        ),
      ),
    );
  }
}
