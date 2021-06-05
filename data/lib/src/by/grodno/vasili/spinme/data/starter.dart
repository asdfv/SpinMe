import 'package:data/src/by/grodno/vasili/spinme/data/models/task_entity.dart';
import 'package:hive/hive.dart';

/// Run this method to init required by data module initializations.
Future initDataLayer(String appDocumentDir) async {
  Hive
    ..init(appDocumentDir)
    ..registerAdapter(TaskEntityAdapter());

  _tasksBox = await Hive.openBox<TaskEntity>('tasksBox');
  // todo for development needs is useful to recreate tasks each start
  // if (_tasksBox!.isEmpty) _tasksBox!.putAll(_defaultTasks());
  _tasksBox!.putAll(_defaultTasks());
}

Box<TaskEntity> getTasksBox() {
  if (_tasksBox == null) throw Exception("Data layer is not initialized, call `start` before.");
  return _tasksBox!;
}

Box<TaskEntity>? _tasksBox;

/// Run this method to release resources used by data module.
void stopDataLayer() {
  Hive.close();
}

Map<int, TaskEntity> _defaultTasks() {
  final descriptions = [
    '1Dance jiga dryga',
    '1Drink 0.5L of water',
    '1Tell any tongue-twister 10 times',
    '1Do 10 somersaults',
    '1Squeeze out 20 times',
    '1Sing a song in English',
    '1Tell the fictional story about photo in your phone',
    '1Show double biceps in front',
  ];
  final descMap = descriptions.asMap();
  return {for (final id in descMap.keys) id: TaskEntity(id, descMap[id]!, true)};
}
