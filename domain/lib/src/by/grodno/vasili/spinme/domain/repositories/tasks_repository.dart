import 'package:domain/domain_module.dart';

/// Data abstraction for work with tasks.
abstract class TasksRepository {

  /// Get all tasks.
  Future<List<Task>> getAllTasks();

  /// Delete task by [id].
  Future delete(int id);

  /// Save one [task].
  Future<int> saveTask(Task task);

  /// Save list of [tasks].
  Future saveTasks(List<Task> tasks);
}
