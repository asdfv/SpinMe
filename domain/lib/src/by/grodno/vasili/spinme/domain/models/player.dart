import 'package:equatable/equatable.dart';

class Player extends Equatable {
  Player(this.id, this.name);

  final int id;
  final String name;

  @override
  List<Object?> get props => [id];
}
