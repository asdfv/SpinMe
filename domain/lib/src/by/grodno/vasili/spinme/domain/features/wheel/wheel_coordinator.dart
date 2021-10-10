import 'package:domain/domain_module.dart';
import 'package:domain/src/by/grodno/vasili/spinme/domain/features/wheel/tasks_picker/tasks_picker.dart';

/// Coordinator to handle game process screen.
class WheelCoordinator {
  final TasksRepository _tasksRepository;
  final PlayersRepository _playersRepository;
  final Settings _settings;
  TasksPicker? _tasksPicker;
  final log = getLogger();

  WheelCoordinator(this._tasksRepository, this._playersRepository, this._settings);

  /// Pick task that is checked during prepare flow according [TasksPicker] logic.
  Future<Task?> pickTaskFor(Player player) async {
    if (_tasksPicker == null) {
      final tasks = _tasksRepository.getAllTasks().then((tasks) => tasks.where((t) => t.isChecked).toList());
      var gameMode = _settings.gameMode;
      _tasksPicker = TasksPicker.createTasksPicker(gameMode, await tasks);
      log.i(message: "Game mode $gameMode is enabled.");
    }
    return _tasksPicker!.pick(player.id);
  }

  /// Get player by his [id].
  Future<Player> getPlayer(int id) => _playersRepository.getPlayer(id);

  /// Get created during preparation flow players.
  Future<List<Player>> getPlayers() => _playersRepository.getPlayers();
}
