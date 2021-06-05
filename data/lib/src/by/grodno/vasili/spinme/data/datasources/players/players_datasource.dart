import 'package:data/src/by/grodno/vasili/spinme/data/models/player_entity.dart';

abstract class PlayerDatasource {
  void savePlayers(List<PlayerEntity> players);
  Future<List<PlayerEntity>> getPlayers();
  Future<PlayerEntity> getPlayer(int id);
  Future deleteAllPlayers();
}
