import 'package:domain/domain_module.dart';

abstract class TasksRepository {
  Future<List<Task>> getAllTasks();

  Future delete(int id);

  Future<int> saveTask(Task task);

  Future saveTasks(List<Task> tasks);
}
