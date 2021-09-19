import 'dart:math';

import 'package:domain/domain_module.dart';

import 'tasks_picker.dart';

/// [TasksPicker] with the logic to repeat task for the player during the Game.
/// @see [TaskPickingMode].
class RepeatableForPlayerTasksPicker extends TasksPicker {
  final List<Player> _players;
  final List<Task> _tasks;

  RepeatableForPlayerTasksPicker(this._players, this._tasks);

  /// TODO implement logic
  @override
  Task pick(Player player) {
    final checkedTasks = _tasks.where((element) => element.isChecked).toList();
    final length = checkedTasks.length;
    final index = Random().nextInt(length);
    return checkedTasks[index];
  }
}
