import 'package:data/src/by/grodno/vasili/spinme/data/datasources/players/players_datasource.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/models/player_entity.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/starter.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/utilities/utilities.dart';

class HivePlayersDatasource extends PlayerDatasource {
  final _playersBox = playersBox;

  @override
  Future<List<PlayerEntity>> getPlayers() {
    return runDelayed(() => _playersBox.values.toList());
  }

  @override
  void savePlayers(List<PlayerEntity> players) {
    _playersBox.addAll(players);
  }

  @override
  Future<PlayerEntity> getPlayer(int id) {
    return Future.value(_playersBox.get(id));
  }

  @override
  Future deleteAllPlayers() {
    _playersBox.clear();
    return Future.value(null);
  }
}
