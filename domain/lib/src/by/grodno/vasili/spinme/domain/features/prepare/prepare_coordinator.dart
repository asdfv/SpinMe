import 'tasks_repository.dart';

class PrepareCoordinator {
  final TasksRepository _repository;

  PrepareCoordinator(this._repository);

  Future<List<String>> getAllTasks() async {
    return _repository.getAllTasks();
  }
}
