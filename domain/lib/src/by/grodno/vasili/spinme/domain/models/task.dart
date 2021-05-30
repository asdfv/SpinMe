import 'package:equatable/equatable.dart';

class Task extends Equatable {
  Task(this.id, this.description, this.isChecked);

  final int id;
  final String description;
  final bool isChecked;

  @override
  List<Object?> get props => [id];
}
