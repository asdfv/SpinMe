import 'dart:math';

import 'package:domain/domain_module.dart';

class WheelCoordinator {
  final TasksRepository _taskRepository;
  final PlayersRepository _playerRepository;
  final log = getLogger();

  WheelCoordinator(this._taskRepository, this._playerRepository);

  Future<Task> pickTask() async {
    final tasks = await _taskRepository.getAllTasks();
    final checkedTasks = tasks.where((element) => element.isChecked).toList();
    final length = checkedTasks.length;
    final index = Random().nextInt(length);
    final pickedTask = checkedTasks[index];
    log.i(message: "Picked task $pickedTask from $length tasks.");
    return pickedTask;
  }

  Future<Player> pickPlayer(int id) => _playerRepository.getPlayer(id);

  Future<List<Task>> getChosenTasks() async {
    final tasks = await _taskRepository.getAllTasks();
    final chosenTasks = tasks.where((element) => element.isChecked).toList();
    return chosenTasks;
  }

  Future<List<Player>> getChosenPlayers() => _playerRepository.getPlayers();
}
