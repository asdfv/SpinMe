import 'package:domain/domain_module.dart';

abstract class TasksRepository {
  Future<List<Task>> getAllTasks();

  // todo replace String? with String and throw error
  Future<Task?> getOne(int index);

  // todo throw error if index is wrong
  Future delete(int id);

  Future<int> size();

  Future<int> saveTask(Task task);

  void saveTasks(List<Task> tasks);
}
