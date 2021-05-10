import 'tasks_repository.dart';

class PrepareCoordinator {
  final TasksRepository _repository;

  PrepareCoordinator(this._repository);

  List<String> getAllTasks() {
    return _repository.getAllTasks();
  }
}
