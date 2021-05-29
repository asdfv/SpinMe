import 'package:domain/domain_module.dart';

class PrepareCoordinator {
  final TasksRepository _tasksRepository;
  final PlayersRepository _playersRepository;

  PrepareCoordinator(this._tasksRepository, this._playersRepository);

  Future<List<Task>> getAllTasks() async {
    return _tasksRepository.getAllTasks();
  }

  Future<List<Player>> getAllPlayers() => _playersRepository.getPlayers();

  void saveAllPlayers(List<Player> players) {
    _playersRepository.savePlayers(players);
  }
}
