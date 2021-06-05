import 'package:domain/domain_module.dart';

abstract class TasksRepository {
  Future<List<Task>> getAllTasks();

  Future<Task?> getRandomly();

  Future delete(int id);

  Future<int> saveTask(Task task);

  void saveTasks(List<Task> tasks);
}
