import 'dart:math';

import '../../repositories/tasks_repository.dart';

class WheelCoordinator {
  final TasksRepository _repository;

  WheelCoordinator(this._repository);

  Future<String> pickTask() async {
    final size = await _repository.size();
    final index = Random().nextInt(size - 1);
    final task = await _repository.getOne(index);
    _repository.delete(index);
    return task!;
  }
}
