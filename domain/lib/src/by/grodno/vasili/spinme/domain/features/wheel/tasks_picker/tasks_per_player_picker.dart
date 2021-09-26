import 'dart:collection';

import 'package:domain/domain_module.dart';

import 'tasks_picker.dart';

/// [TasksPicker] with the logic to repeat tasks for the player during the Game.
/// @see [TaskPickingMode].
class TasksPerPlayerPicker extends TasksPicker {
  final List<Task> _initialTasks;
  final Map<int, Queue<Task>> _tasksById = Map();

  TasksPerPlayerPicker(this._initialTasks);

  @override
  Task? pick(int id) {
    if (_tasksById[id] == null) {
      final List<Task> shuffledTasks = List.from(_initialTasks)..shuffle();
      _tasksById[id] = Queue.from(shuffledTasks);
    }
    if (_tasksById[id]!.isEmpty) return null;
    return _tasksById[id]!.removeFirst();
  }
}
