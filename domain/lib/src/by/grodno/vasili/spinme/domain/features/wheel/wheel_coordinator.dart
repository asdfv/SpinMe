import 'dart:math';

import 'package:domain/domain_module.dart';

/// Coordinator to handle game process screen.
class WheelCoordinator {
  final TasksRepository _tasksRepository;
  final PlayersRepository _playersRepository;
  final log = getLogger();

  WheelCoordinator(this._tasksRepository, this._playersRepository);

  /// Pick randomly checked during prepare flow task.
  Future<Task> pickTask() async {
    final tasks = await _tasksRepository.getAllTasks();
    final checkedTasks = tasks.where((element) => element.isChecked).toList();
    final length = checkedTasks.length;
    final index = Random().nextInt(length);
    final pickedTask = checkedTasks[index];
    log.i(message: "Picked task $pickedTask from $length tasks.");
    return pickedTask;
  }

  /// Get player by his id.
  Future<Player> pickPlayer(int id) => _playersRepository.getPlayer(id);

  /// Get created during preparation flow players.
  Future<List<Player>> getChosenPlayers() => _playersRepository.getPlayers();
}
