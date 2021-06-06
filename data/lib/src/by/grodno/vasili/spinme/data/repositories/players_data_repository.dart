import 'package:data/src/by/grodno/vasili/spinme/data/datasources/players/players_datasource.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/models/player_entity.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/utilities/utilities.dart';
import 'package:domain/domain_module.dart';

class PlayersDataRepository extends PlayersRepository {
  PlayersDataRepository(this._playersDatasource);

  final log = getLogger();
  final PlayerDatasource _playersDatasource;

  @override
  Future<List<Player>> getPlayers() {
    return _playersDatasource.getPlayers().then((value) => value.map((entity) => entity.toDomainModel()).toList());
  }

  @override
  Future savePlayers(List<Player> players) async {
    await _playersDatasource.savePlayers(players.map((player) => PlayerEntity.fromDomainModel(player)).toList());
    log.d(message: "${players.length} players saved.");
  }

  @override
  Future<Player> getPlayer(int id) {
    return _playersDatasource.getPlayer(id).then((entity) => entity.toDomainModel());
  }

  @override
  Future deleteAllPlayers() {
    _playersDatasource.deleteAllPlayers();
    return runDelayed(() => null);
  }
}
