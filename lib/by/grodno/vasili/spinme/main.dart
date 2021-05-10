import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:data/data_module.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tasks = TasksRepository().getAll();
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
