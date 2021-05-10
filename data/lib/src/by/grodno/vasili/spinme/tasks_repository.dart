class TasksRepository {
  final List<String> _tasks = List.generate(30, (index) => 'Task number $index');

  List<String> getAll() {
    return _tasks;
  }

  void add(String todo) {
    _tasks.add(todo);
  }
}
