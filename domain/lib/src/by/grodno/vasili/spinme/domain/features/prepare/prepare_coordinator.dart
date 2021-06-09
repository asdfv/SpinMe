import 'package:domain/domain_module.dart';

/// Coordinator for the flow before the game when user can choose manes for players and tasks to do.
class PrepareCoordinator {
  final TasksRepository _tasksRepository;
  final PlayersRepository _playersRepository;

  PrepareCoordinator(this._tasksRepository, this._playersRepository);

  /// Get all saved tasks.
  Future<List<Task>> getAllTasks() async {
    return _tasksRepository.getAllTasks();
  }

  /// Gat all saved players.
  Future<List<Player>> getAllPlayers() => _playersRepository.getPlayers();

  /// Remove all existing players and add new [players].
  Future replaceAllPlayers(List<Player> players) async {
    await _playersRepository.deleteAllPlayers();
    await _playersRepository.savePlayers(players);
  }

  /// Save lis of [tasks].
  Future saveTasks(List<Task> tasks) async {
    await _tasksRepository.saveTasks(tasks);
  }

  /// Save one [task].
  Future saveTask(Task updatedTask) async {
    await _tasksRepository.saveTask(updatedTask);
  }

  Future deleteTask(id) async {
    await _tasksRepository.delete(id);
  }
}
