abstract class TasksRepository {
  Future<List<String>> getAllTasks();

  // todo replace String? with String and throw error
  Future<String?> getOne(int index);

  // todo throw error if index is wrong
  Future delete(int index);

  Future<int> size();
}
