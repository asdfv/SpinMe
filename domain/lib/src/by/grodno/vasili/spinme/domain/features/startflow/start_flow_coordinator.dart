import 'tasks_repository.dart';

class StartFlowCoordinator {
  final TasksRepository _repository;

  StartFlowCoordinator(this._repository);

  List<String> getAllTasks() {
    return _repository.getAllTasks();
  }
}
