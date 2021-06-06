import 'package:data/src/by/grodno/vasili/spinme/data/datasources/tasks/tasks_datasource.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/models/task_entity.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/starter.dart';

class HiveTasksDatasource extends TasksDatasource {
  final _tasksBox = tasksBox;

  @override
  Future delete(int id) {
    _tasksBox.delete(id);
    return Future.value();
  }

  @override
  Future<List<TaskEntity>> getAll() {
    return Future.value(_tasksBox.values.toList());
  }

  @override
  Future<int> saveTask(TaskEntity task) {
    _tasksBox.put(task.id, task);
    return Future.value(task.id);
  }

  @override
  void saveTasks(List<TaskEntity> tasks) {
    final tasksMap = {for (final task in tasks) task.id: task};
    _tasksBox.putAll(tasksMap);
  }
}
