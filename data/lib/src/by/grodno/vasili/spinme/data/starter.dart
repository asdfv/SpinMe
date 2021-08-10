import 'package:data/src/by/grodno/vasili/spinme/data/models/member_entity.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/models/player_entity.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/models/task_entity.dart';
import 'package:hive/hive.dart';

/// Run this method to perform required by data module initializations.
Future startDataLayer(String appDocumentDir) async {
  Hive
    ..init(appDocumentDir)
    ..registerAdapter(TaskEntityAdapter())
    ..registerAdapter(PlayerEntityAdapter())
    ..registerAdapter(MemberEntityAdapter());

  tasksBox = await Hive.openBox<TaskEntity>('tasksBox');
  playersBox = await Hive.openBox<PlayerEntity>('playersBox');
  memberBox = await Hive.openBox<MemberEntity>('memberBox');

  if (tasksBox.isEmpty) tasksBox.putAll(_defaultTasks());
  if (playersBox.isEmpty) playersBox.putAll(_defaultPlayers());
}

/// Run this method to release resources used by data module.
void stopDataLayer() {
  Hive.close();
}

/// [Box] with tasks.
late Box<TaskEntity> tasksBox;

/// [Box] with players.
late Box<PlayerEntity> playersBox;

/// [Box] with member.
late Box<MemberEntity> memberBox;

Map<int, PlayerEntity> _defaultPlayers() {
  final names = [
    "Jake",
    "Jane",
  ];
  final namesMap = names.asMap();
  return {for (final id in namesMap.keys) id: PlayerEntity(id, namesMap[id]!)};
}

Map<int, TaskEntity> _defaultTasks() {
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
