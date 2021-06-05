import 'package:domain/domain_module.dart';

class WheelCoordinator {
  final TasksRepository _taskRepository;
  final PlayersRepository _playerRepository;

  WheelCoordinator(this._taskRepository, this._playerRepository);

  Future<Task> pickTask() async {
    final task = await _taskRepository.getRandomly();
    return task!;
  }

  Future<Player> pickPlayer(int id) => _playerRepository.getPlayer(id);

  Future<List<Task>> getChosenTasks() async {
    final tasks = await _taskRepository.getAllTasks();
    final chosenTasks = tasks.where((element) => element.isChecked).toList();
    return chosenTasks;
  }

  Future<List<Player>> getChosenPlayers() => _playerRepository.getPlayers();
}
