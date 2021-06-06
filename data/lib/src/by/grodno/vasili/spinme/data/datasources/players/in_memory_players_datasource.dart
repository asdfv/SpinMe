import 'package:data/src/by/grodno/vasili/spinme/data/datasources/players/players_datasource.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/models/player_entity.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/utilities/utilities.dart';

class InMemoryPlayersDatasource extends PlayerDatasource {
  final Map<int, PlayerEntity> _playersDatasource = {
    0: PlayerEntity(0, "Vasili"),
    1: PlayerEntity(1, "Jake"),
    2: PlayerEntity(2, "Jane"),
  };

  @override
  Future<List<PlayerEntity>> getPlayers() {
    return runDelayed(() => _playersDatasource.values.toList());
  }

  @override
  void savePlayers(List<PlayerEntity> players) {
    _playersDatasource.addAll(players.asMap());
  }

  @override
  Future<PlayerEntity> getPlayer(int id) {
    return runDelayed(() => _playersDatasource[id]!);
  }

  @override
  Future deleteAllPlayers() {
    _playersDatasource.clear();
    return runDelayed(() => null);
  }
}
