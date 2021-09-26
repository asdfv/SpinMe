import 'dart:collection';

import 'package:domain/domain_module.dart';

import 'tasks_picker.dart';

/// [TasksPicker] with the logic to repeat tasks for the player during the Game.
/// @see [TaskPickingMode].
class RepeatableForPlayerTasksPicker extends TasksPicker {
  final List<Task> _tasks;
  final Map<int, Queue<Task>> _tasksById = Map();

  RepeatableForPlayerTasksPicker(this._tasks);

  @override
  Task pick(int id) {
    var playersTasks = _tasksById[id];
    if (playersTasks == null || playersTasks.isEmpty) {
      final List<Task> shuffledTasks = List.from(_tasks)..shuffle();
      _tasksById[id] = Queue.from(shuffledTasks);
    }
    return _tasksById[id]!.removeFirst();
  }
}
