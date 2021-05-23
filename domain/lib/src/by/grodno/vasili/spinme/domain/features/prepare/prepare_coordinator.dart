import 'package:domain/domain_module.dart';

import '../../repositories/tasks_repository.dart';

class PrepareCoordinator {
  final TasksRepository _tasksRepository;
  final PlayersRepository _playersRepository;

  PrepareCoordinator(this._tasksRepository, this._playersRepository);

  Future<List<String>> getAllTasks() async {
    return _tasksRepository.getAllTasks();
  }

  Future<List<Player>> getAllPlayers() => _playersRepository.getPlayers();

  void saveAllPlayers(List<Player> players) {
    _playersRepository.savePlayers(players);
  }
}
