import 'package:domain/domain_module.dart';

abstract class PlayersRepository {
  Future savePlayers(List<Player> players);
  Future<List<Player>> getPlayers();
  Future<Player> getPlayer(int id);
  Future deleteAllPlayers();
}
