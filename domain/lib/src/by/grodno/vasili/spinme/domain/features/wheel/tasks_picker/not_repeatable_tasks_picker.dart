import 'dart:math';

import 'package:domain/domain_module.dart';

import 'tasks_picker.dart';

/// [TasksPicker] with the logic to not repeat any task during the Game.
/// @see [TaskPickingMode].
class NotRepeatableTasksPicker extends TasksPicker {
  final List<Player> _players;
  final List<Task> _tasks;

  NotRepeatableTasksPicker(this._players, this._tasks);

  /// TODO implement logic
  @override
  Task pick(Player player) {
    final checkedTasks = _tasks.where((element) => element.isChecked).toList();
    final length = checkedTasks.length;
    final index = Random().nextInt(length);
    return checkedTasks[index];
  }
}
