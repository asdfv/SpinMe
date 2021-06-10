import 'package:equatable/equatable.dart';

/// Player domain model.
class Player extends Equatable {
  const Player(this.id, this.name);

  final int id;
  final String name;

  @override
  List<Object?> get props => [id];
}
