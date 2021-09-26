import 'package:domain/domain_module.dart';

import 'non_repeatable_tasks_picker.dart';
import 'repeatable_for_player_tasks_picker.dart';

/// Interface which can [pick] appropriate [Task] for chosen by wheel [Player.id].
/// There is enum [TaskPickingMode] to set the logic for picking.
/// This class keeps the state and should be created one instance per game session.
abstract class TasksPicker {
  Task pick(int id);

  /// Create [TasksPicker] instance based on [TaskPickingMode].
  static TasksPicker createTasksPicker(TaskPickingMode mode, List<Task> tasks) {
    switch (mode) {
      case TaskPickingMode.notRepeat:
        return NonRepeatableTasksPicker(tasks);
      case TaskPickingMode.repeatForPlayer:
        return RepeatableForPlayerTasksPicker(tasks);
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
