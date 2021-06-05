import 'package:data/src/by/grodno/vasili/spinme/data/models/task_entity.dart';

abstract class TasksDatasource {
  Future<List<TaskEntity>> getAll();

  Future<TaskEntity?> getOne(int index);

  Future delete(int id);

  Future<int> size();

  Future<int> saveTask(TaskEntity task);

  void saveTasks(List<TaskEntity> tasks);
}
