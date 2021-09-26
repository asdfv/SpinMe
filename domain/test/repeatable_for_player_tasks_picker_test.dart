import 'package:collection/collection.dart';
import 'package:domain/domain_module.dart';
import 'package:domain/src/by/grodno/vasili/spinme/domain/features/wheel/tasks_picker/repeatable_for_player_tasks_picker.dart';
import 'package:test/test.dart';

import 'test_data.dart';

void main() {
  const TASKS_LENGTH = 10;
  const PLAYER_ID = 13;
  final _tasks = createMockedTasks(TASKS_LENGTH);
  late RepeatableForPlayerTasksPicker _picker;

  setUp(() {
    _picker = RepeatableForPlayerTasksPicker(_tasks);
  });

  test('Picker does not repeat the same task twice before all tasks over for particular player', () {
    final Set<Task> tasksSet = Set();
    for (var i = 0; i < _tasks.length; i++) {
      tasksSet.add(_picker.pick(PLAYER_ID));
    }
    final expectedLength = _tasks.length;
    final actualLength = tasksSet.length;
    expect(actualLength, expectedLength);
  });

  test('Picker repeat each task twice in case of two loops', () {
    final List<Task> tasks = List.empty(growable: true);
    for (var i = 0; i < 2 * _tasks.length; i++) {
      tasks.add(_picker.pick(PLAYER_ID));
    }
    final sortedIds = tasks.map((task) => task.id).toList();
    sortedIds.sort();
    for (var i = 0; i < 2 * _tasks.length; i = i + 2) {
      final firstId = sortedIds[i];
      final secondId = sortedIds[i + 1];
      expect(firstId, secondId);
    }
  });

  test('Picker shuffle the tasks', () {
    final List<Task> tasks = List.empty(growable: true);
    for (var i = 0; i < _tasks.length; i++) {
      tasks.add(_picker.pick(PLAYER_ID));
    }

    expect(ListEquality().equals(tasks, _tasks), isFalse);
  });
}
