import 'dart:collection';

import 'package:domain/domain_module.dart';

import 'tasks_picker.dart';

/// [TasksPicker] with the logic to not repeat any task during the Game.
/// @see [TaskPickingMode].
class TasksPerGamePicker extends TasksPicker {
  final List<Task> _initialTasks;
  Queue<Task>? _tasks;

  TasksPerGamePicker(this._initialTasks);

  @override
  Task? pick(int id) {
    if (_tasks == null) _tasks = Queue.from(List.from(_initialTasks)..shuffle());
    if (_tasks!.isEmpty) return null;
    return _tasks!.removeFirst();
  }
}
