import 'package:data/src/by/grodno/vasili/spinme/data/models/task_entity.dart';

/// Interface for task datasources.
abstract class TasksDatasource {
  Future<List<TaskEntity>> getAll();
  Future delete(int id);
  Future<int> saveTask(TaskEntity task);
  Future saveTasks(List<TaskEntity> tasks);
}
