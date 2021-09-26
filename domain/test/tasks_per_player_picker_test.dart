import 'package:collection/collection.dart';
import 'package:domain/domain_module.dart';
import 'package:domain/src/by/grodno/vasili/spinme/domain/features/wheel/tasks_picker/tasks_per_player_picker.dart';
import 'package:test/test.dart';

import 'test_data.dart';

void main() {
  const TASKS_LENGTH = 10;
  const PLAYER_ID = 13;
  final _tasks = createMockedTasks(TASKS_LENGTH);
  late TasksPerPlayerPicker _picker;

  setUp(() {
    _picker = TasksPerPlayerPicker(_tasks);
  });

  test('Picker gives all tasks without repetitions for particular player', () {
    final Set<Task> tasksSet = Set();
    for (var i = 0; i < _tasks.length; i++) {
      tasksSet.add(_picker.pick(PLAYER_ID)!);
    }
    final expectedLength = _tasks.length;
    final actualLength = tasksSet.length;
    expect(actualLength, expectedLength);
  });

  // todo https://trello.com/c/MUUiokwa
  test('Picker returns null if tasks over for one of the player', () {});

  test('Picker shuffle the tasks', () {
    final List<Task> tasks = List.empty(growable: true);
    for (var i = 0; i < _tasks.length; i++) {
      tasks.add(_picker.pick(PLAYER_ID)!);
    }

    expect(ListEquality().equals(tasks, _tasks), isFalse);
  });
}
