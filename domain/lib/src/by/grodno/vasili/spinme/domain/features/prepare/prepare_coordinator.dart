import 'package:domain/domain_module.dart';

class PrepareCoordinator {
  final TasksRepository _tasksRepository;
  final PlayersRepository _playersRepository;

  PrepareCoordinator(this._tasksRepository, this._playersRepository);

  Future<List<Task>> getAllTasks() async {
    return _tasksRepository.getAllTasks();
  }

  Future<List<Player>> getAllPlayers() => _playersRepository.getPlayers();

  Future replaceAllPlayers(List<Player> players) async {
    await _playersRepository.deleteAllPlayers();
    await _playersRepository.savePlayers(players);
  }

  Future saveTasks(List<Task> tasks) async {
    await _tasksRepository.saveTasks(tasks);
  }

  Future saveTask(Task updatedTask) async {
    await _tasksRepository.saveTask(updatedTask);
  }

  Future deleteTask(id) async {
    await _tasksRepository.delete(id);
  }
}
