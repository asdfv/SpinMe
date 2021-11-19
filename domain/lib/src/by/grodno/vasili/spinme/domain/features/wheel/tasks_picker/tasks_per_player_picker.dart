import 'dart:collection';

import 'package:domain/domain_module.dart';

import 'tasks_picker.dart';

/// [TasksPicker] with the logic to repeat tasks for the player during the Game.
/// @see [GameMode].
class TasksPerPlayerPicker extends TasksPicker {
  final List<Task> _initialTasks;
  final Map<int, Queue<Task>> _tasksById = Map();

  TasksPerPlayerPicker(this._initialTasks);

  @override
  Task? pick(int playerId) {
    if (_tasksById[playerId] == null) {
      final List<Task> shuffledTasks = List.from(_initialTasks)..shuffle();
      _tasksById[playerId] = Queue.from(shuffledTasks);
    }
    if (_tasksById[playerId]!.isEmpty) return null;
    return _tasksById[playerId]!.removeFirst();
  }
}
