import 'package:domain/domain_module.dart';

class FakePlayersRepository extends PlayersRepository {
  final log = getLogger();
  final List<Player> _playersDatasource = [];

  @override
  Future<List<Player>> getPlayers() {
    return Future.delayed(const Duration(milliseconds: 200), () => _playersDatasource);
  }

  @override
  void savePlayers(List<Player> players) {
    _playersDatasource.addAll(players);
    log.d(message: "${players.length} players saved.");
  }
}
