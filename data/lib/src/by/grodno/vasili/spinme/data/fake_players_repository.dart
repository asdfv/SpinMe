import 'package:data/src/by/grodno/vasili/spinme/data/models/player_entity.dart';
import 'package:domain/domain_module.dart';

import 'utilities/utilities.dart';

class FakePlayersRepository extends PlayersRepository {
  final log = getLogger();
  final List<PlayerEntity> _playersDatasource = [];

  @override
  Future<List<Player>> getPlayers() {
    return runDelayed(() => _playersDatasource.map((entity) => entity.toDomainModel()).toList());
  }

  @override
  void savePlayers(List<Player> players) {
    _playersDatasource.addAll(players.map((player) => PlayerEntity.fromDomainModel(player)));
    log.d(message: "${players.length} players saved.");
  }

  @override
  Future<Player> getPlayer(int id) {
    return runDelayed(() => _playersDatasource[id].toDomainModel());
  }

  @override
  Future deleteAllPlayers() {
    _playersDatasource.clear();
    return runDelayed(() => null);
  }
}
