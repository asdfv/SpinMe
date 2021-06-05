import 'dart:math';

import 'package:data/src/by/grodno/vasili/spinme/data/datasources/tasks/tasks_datasource.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/models/task_entity.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/utilities/utilities.dart';
import 'package:domain/domain_module.dart';

class InMemoryTasksDatasource extends TasksDatasource {
  final log = getLogger();

  final Map<int, TaskEntity> _tasksDatasource = {
    0: TaskEntity(0, 'Dance jiga dryga', true),
    1: TaskEntity(1, 'Drink 0.5L of water', true),
    2: TaskEntity(2, 'Tell any tongue-twister 10 times', true),
    3: TaskEntity(3, 'Do 10 somersaults', true),
    4: TaskEntity(4, 'Squeeze out 20 times', true),
    5: TaskEntity(5, 'Sing a song in English', true),
    6: TaskEntity(6, 'Tell the fictional story about photo in your phone', true),
    7: TaskEntity(7, 'Show double biceps in front', false),
  };

  @override
  Future<List<TaskEntity>> getAll() async {
    return runDelayed(() => _tasksDatasource.values.toList());
  }

  @override
  Future<TaskEntity?> getRandomly() {
    final length = _tasksDatasource.length;
    if (length == 0) return runDelayed(() => null);
    final index = Random().nextInt(length - 1);
    final entities = _tasksDatasource.values.toList();
    return runDelayed(() => entities[index]);
  }

  @override
  Future delete(int id) {
    _tasksDatasource.remove(id);
    return runDelayed(() => null);
  }

  @override
  Future<int> saveTask(TaskEntity task) {
    _tasksDatasource[task.id] = task;
    return runDelayed(() => task.id);
  }

  @override
  void saveTasks(List<TaskEntity> tasks) {
    tasks.forEach((task) {
      saveTask(task);
    });
    final savedTasksIds = tasks.where((task) => task.isChecked).map((task) => task.id).join(", ");
    log.i(message: "Tasks saved in memory. Checked tasks from them are: $savedTasksIds");
  }
}
