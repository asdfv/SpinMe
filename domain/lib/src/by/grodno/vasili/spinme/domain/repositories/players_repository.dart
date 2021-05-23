import 'package:domain/domain_module.dart';

abstract class PlayersRepository {
  void savePlayers(List<Player> players);
  Future<List<Player>> getPlayers();
}
