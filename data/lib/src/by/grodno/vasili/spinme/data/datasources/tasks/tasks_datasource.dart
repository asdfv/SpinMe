import 'package:data/src/by/grodno/vasili/spinme/data/models/task_entity.dart';

abstract class TasksDatasource {
  Future<List<TaskEntity>> getAll();

  Future<TaskEntity?> getRandomly();

  Future delete(int id);

  Future<int> saveTask(TaskEntity task);

  void saveTasks(List<TaskEntity> tasks);
}
