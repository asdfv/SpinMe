import 'package:domain/domain_module.dart';
import 'package:hive/hive.dart';

part 'player_entity.g.dart';

@HiveType(typeId: 1)
class PlayerEntity {
  PlayerEntity(this.id, this.name);

  PlayerEntity.fromDomainModel(Player player)
      : this.id = player.id,
        this.name = player.name;

  @HiveField(0)
  int id;

  @HiveField(1)
  String name;
}

extension PlayerEntityConverter on PlayerEntity {
  Player toDomainModel() => Player(this.id, this.name);
}
