import 'package:domain/domain_module.dart';

import 'not_repeatable_tasks_picker.dart';
import 'repeatable_for_player_tasks_picker.dart';

/// Interface which can [pick] appropriate [Task] for chosen by wheel [Player].
/// There is enum [TaskPickingMode] to set the logic for picking.
abstract class TasksPicker {
  Task pick(Player player);

  /// Create [TasksPicker] instance based on [TaskPickingMode].
  static TasksPicker createTasksPicker(TaskPickingMode mode, List<Player> players, List<Task> tasks) {
    switch (mode) {
      case TaskPickingMode.notRepeat:
        return NotRepeatableTasksPicker(players, tasks);
      case TaskPickingMode.repeatForPlayer:
        return RepeatableForPlayerTasksPicker(players, tasks);
    }
  }
}

/// Mode for picking the task for each player.
enum TaskPickingMode {
  /// Each new wheel spin pick the new task which will not appear again in this game.
  /// Game is finished when tasks are over.
  notRepeat,

  /// Each player have individual set of tasks which can be repeated
  /// in case he did all the tasks from the set already.
  /// Within each loop for particular player tasks are not repeated.
  /// When all the players did all tasks from its sets then game is over.
  repeatForPlayer
}
