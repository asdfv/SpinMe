import 'package:equatable/equatable.dart';

class Player extends Equatable {
  Player({required this.id, required this.name});

  final int id;
  final String name;

  @override
  List<Object?> get props => [id];
}
