import 'package:domain/domain_module.dart';

import 'tasks_per_game_picker.dart';
import 'tasks_per_player_picker.dart';

/// Interface which can [pick] appropriate [Task] for chosen by wheel [Player.id].
/// There is enum [TaskPickingMode] to set the logic for picking.
/// This class keeps the state and should be created one instance per game session.
abstract class TasksPicker {

  /// Pick the Task according the rules by id.
  /// Returns null if tasks over which means that game is over.
  Task? pick(int id);

  /// Create [TasksPicker] instance based on [TaskPickingMode].
  static TasksPicker createTasksPicker(TaskPickingMode mode, List<Task> tasks) {
    switch (mode) {
      case TaskPickingMode.tasksPerGame:
        return TasksPerGamePicker(tasks);
      case TaskPickingMode.tasksPerPlayer:
        return TasksPerPlayerPicker(tasks);
    }
  }
}

/// Mode for picking the task for each player.
enum TaskPickingMode {
  /// Each new wheel spin pick the new task which will not appear again in this game.
  /// Game is finished when tasks are over.
  tasksPerGame,

  /// Each player have own but the same as others set of tasks which cannot be repeated.
  /// When one of the players did all tasks from his sets then game is over.
  tasksPerPlayer
}
