import 'package:domain/domain_module.dart';

class TaskEntity {
  TaskEntity(this.id, this.description);

  final int id;
  final String description;
}

extension TaskEntityConverter on TaskEntity {
  Task toDomainModel() => Task(this.id, this.description);
}
