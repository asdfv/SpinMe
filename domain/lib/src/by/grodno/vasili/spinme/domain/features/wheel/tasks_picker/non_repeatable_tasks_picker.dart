import 'dart:math';

import 'package:domain/domain_module.dart';

import 'tasks_picker.dart';

/// [TasksPicker] with the logic to not repeat any task during the Game.
/// @see [TaskPickingMode].
class NonRepeatableTasksPicker extends TasksPicker {
  final List<Task> _tasks;

  NonRepeatableTasksPicker(this._tasks);

  /// TODO implement logic
  @override
  Task pick(int id) {
    final checkedTasks = _tasks.where((element) => element.isChecked).toList();
    final length = checkedTasks.length;
    final index = Random().nextInt(length);
    return checkedTasks[index];
  }
}
