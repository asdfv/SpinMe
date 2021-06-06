import 'package:domain/domain_module.dart';

class PrepareCoordinator {
  final TasksRepository _tasksRepository;
  final PlayersRepository _playersRepository;

  PrepareCoordinator(this._tasksRepository, this._playersRepository);

  Future<List<Task>> getAllTasks() async {
    return _tasksRepository.getAllTasks();
  }

  Future<List<Player>> getAllPlayers() => _playersRepository.getPlayers();

  void replaceAllPlayers(List<Player> players) async {
    await _playersRepository.deleteAllPlayers();
    _playersRepository.savePlayers(players);
  }

  void saveTasks(List<Task> tasks) {
    _tasksRepository.saveTasks(tasks);
  }

  void saveTask(Task updatedTask) {
    _tasksRepository.saveTask(updatedTask);
  }

  void deleteTask(id) {
    _tasksRepository.delete(id);
  }
}
