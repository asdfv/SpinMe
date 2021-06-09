import 'package:domain/domain_module.dart';

/// Data abstraction to work with players.
abstract class PlayersRepository {

  /// Save all [players].
  Future savePlayers(List<Player> players);

  /// Get all players.
  Future<List<Player>> getPlayers();

  /// Get player by his [id].
  Future<Player> getPlayer(int id);

  /// Remove all players.
  Future deleteAllPlayers();
}
