import 'package:data/src/by/grodno/vasili/spinme/data/datasources/tasks/tasks_datasource.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/models/task_entity.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/starter.dart';

class HiveTasksDatasource extends TasksDatasource {
  final _tasksBox = tasksBox;

  @override
  Future delete(int id) async {
    await _tasksBox.delete(id);
  }

  @override
  Future<List<TaskEntity>> getAll() {
    return Future.value(_tasksBox.values.toList());
  }

  @override
  Future<int> saveTask(TaskEntity task) async {
    await _tasksBox.put(task.id, task);
    return Future.value(task.id);
  }

  @override
  Future saveTasks(List<TaskEntity> tasks) async {
    final tasksMap = {for (final task in tasks) task.id: task};
    await _tasksBox.putAll(tasksMap);
  }
}
