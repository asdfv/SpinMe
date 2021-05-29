import 'package:domain/domain_module.dart';

class PlayerEntity {
  PlayerEntity(this.id, this.name);

  PlayerEntity.fromDomainModel(Player player)
      : this.id = player.id,
        this.name = player.name;

  final int id;
  final String name;
}

extension PlayerEntityConverter on PlayerEntity {
  Player toDomainModel() => Player(this.id, this.name);
}
