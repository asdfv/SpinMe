import 'package:data/src/by/grodno/vasili/spinme/data/models/player_entity.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/models/task_entity.dart';
import 'package:domain/domain_module.dart';
import 'package:hive/hive.dart';

/// Run this method to perform required by data module initializations.
Future startDataLayer(String appDocumentDir) async {
  Hive
    ..init(appDocumentDir)
    ..registerAdapter(TaskEntityAdapter())
    ..registerAdapter(PlayerEntityAdapter());

  tasksBox = await Hive.openBox<TaskEntity>('tasksBox');
  playersBox = await Hive.openBox<PlayerEntity>('playersBox');
  settingsBox = await Hive.openBox<dynamic>('settingsBox');

  if (playersBox.isEmpty) playersBox.putAll(_defaultPlayers());
}

initDefaultTasksIfNeeded(String language) {
  if (tasksBox.isNotEmpty) return;
  getLogger().i(message: "Going to populate Tasks for $language language.");
  switch (language) {
    case 'ru':
      tasksBox.putAll(_defaultRuTasks());
      break;
    case 'en':
      tasksBox.putAll(_defaultEnTasks());
      break;
  }
}

/// Run this method to release resources used by data module.
void stopDataLayer() {
  Hive.close();
}

/// [Box] with tasks.
late Box<TaskEntity> tasksBox;

/// [Box] with players.
late Box<PlayerEntity> playersBox;

/// [Box] with the app settings.
late Box<dynamic> settingsBox;

Map<int, PlayerEntity> _defaultPlayers() {
  final names = [
    "Jake",
    "Jane",
  ];
  final namesMap = names.asMap();
  return {for (final id in namesMap.keys) id: PlayerEntity(id, namesMap[id]!)};
}

Map<int, TaskEntity> _defaultEnTasks() {
  final descriptions = [
    'Dance jiga dryga',
    'Drink 0.5L of water',
    'Tell any tongue-twister 10 times',
    'Do 10 somersaults',
    'Squeeze out 20 times',
    'Sing a song in English',
    'Tell the fictional story about photo in your phone',
    'Show double biceps in front',
  ];
  final descMap = descriptions.asMap();
  return {for (final id in descMap.keys) id: TaskEntity(id, descMap[id]!, true)};
}

Map<int, TaskEntity> _defaultRuTasks() {
  final descriptions = [
    'Станцевать жигу-дрыгу',
    'Выпить поллитра воды',
    'Рассказать любую скороговорку 10 раз',
    'Отжаться 10 раз',
    'Присесть 20 раз',
    'Спеть песню',
    'Придумать и рассказать историю о фото в своем теелфоне',
    'Показать двойной бицепс спереди',
  ];
  final descMap = descriptions.asMap();
  return {for (final id in descMap.keys) id: TaskEntity(id, descMap[id]!, true)};
}
