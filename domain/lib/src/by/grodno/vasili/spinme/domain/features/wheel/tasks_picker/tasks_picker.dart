import 'package:domain/domain_module.dart';

import 'tasks_per_game_picker.dart';
import 'tasks_per_player_picker.dart';

/// Interface which can [pick] appropriate [Task] for chosen by wheel [Player.id].
/// There is enum [GameMode] to set the logic for picking.
/// Implementation should keep the state thus should be created one instance per game session.
abstract class TasksPicker {

  /// Pick the Task according the rules by the Player id.
  /// Returns null if tasks over which means that game is over.
  Task? pick(int playerId);

  /// Create [TasksPicker] instance based on [GameMode].
  static TasksPicker createTasksPicker(GameMode mode, List<Task> tasks) {
    switch (mode) {
      case GameMode.tasksPerGame:
        return TasksPerGamePicker(tasks);
      case GameMode.tasksPerPlayer:
        return TasksPerPlayerPicker(tasks);
    }
  }
}
