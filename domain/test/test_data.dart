import 'package:domain/domain_module.dart';

List<Player> createMockedPlayers(int length) {
  return List.generate(length, (index) => Player(index, "Player_$index"));
}

List<Task> createMockedTasks(int length) {
  return List.generate(length, (index) => Task(index, "Task number $index", index % 2 == 0));
}