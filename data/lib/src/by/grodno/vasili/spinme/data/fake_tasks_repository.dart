import 'package:data/src/by/grodno/vasili/spinme/data/models/task_entity.dart';
import 'package:domain/domain_module.dart';

class FakeTasksRepository extends TasksRepository {
  final List<TaskEntity> _tasksDatasource = List.generate(5, (index) => TaskEntity(index, 'Task number $index', true));

  @override
  Future<List<Task>> getAllTasks() async {
    return Future.delayed(
        const Duration(milliseconds: 200), () => _tasksDatasource.map((entity) => entity.toDomainModel()).toList());
  }

  @override
  Future<Task?> getOne(int id) {
    return Future.delayed(const Duration(milliseconds: 200), () => _tasksDatasource[id].toDomainModel());
  }

  @override
  Future delete(int id) {
    return Future.delayed(const Duration(milliseconds: 200), () => null);
  }

  @override
  Future<int> size() => Future.delayed(const Duration(milliseconds: 200), () => _tasksDatasource.length);
}
