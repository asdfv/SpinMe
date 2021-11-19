import 'dart:math';

import 'package:domain/domain_module.dart';
import 'package:domain/src/by/grodno/vasili/spinme/domain/features/wheel/tasks_picker/tasks_per_game_picker.dart';
import 'package:test/test.dart';

import 'test_data.dart';

void main() {
  const TASKS_LENGTH = 10;
  final _random = Random();
  final _tasks = createMockedTasks(TASKS_LENGTH);
  late TasksPerGamePicker _picker;
  int _randomInt() => _random.nextInt(1<<32);

  setUp(() {
    _picker = TasksPerGamePicker(_tasks);
  });

  test('Picker gives all tasks without repetitions for particular Game', () {
    final Set<Task> tasksSet = Set();
    for (var i = 0; i < _tasks.length; i++) {
      tasksSet.add(_picker.pick(_randomInt())!);
    }
    final expectedLength = _tasks.length;
    final actualLength = tasksSet.length;
    expect(actualLength, expectedLength);
  });

  test('Picker returns null if tasks over for the Game', () {
    for (var i = 0; i < _tasks.length; i++) {
      _picker.pick(_randomInt());
    }
    final afterLastTask = _picker.pick(_randomInt());
    expect(afterLastTask, isNull);
  });
}
