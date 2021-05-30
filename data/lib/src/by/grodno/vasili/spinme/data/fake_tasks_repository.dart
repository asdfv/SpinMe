import 'package:data/src/by/grodno/vasili/spinme/data/models/task_entity.dart';
import 'package:domain/domain_module.dart';

class FakeTasksRepository extends TasksRepository {
  final log = getLogger();

  final Set<TaskEntity> _tasksDatasource = {
    TaskEntity(0, 'Dance jiga dryga', true),
    TaskEntity(1, 'Drink 0.5L of water', true),
    TaskEntity(2, 'Tell any tongue-twister 10 times', true),
    TaskEntity(3, 'Do 10 somersaults', true),
    TaskEntity(4, 'Squeeze out 20 times', true),
    TaskEntity(5, 'Sing a song in English', true),
    TaskEntity(6, 'Tell the fictional story about photo in your phone', true),
    TaskEntity(7, 'Show double biceps in front', false),
  };

  @override
  Future<List<Task>> getAllTasks() async {
    return Future.delayed(
        const Duration(milliseconds: 200), () => _tasksDatasource.map((entity) => entity.toDomainModel()).toList());
  }

  @override
  Future<Task?> getOne(int id) {
    return Future.delayed(
        const Duration(milliseconds: 200), () => _tasksDatasource.firstWhere((task) => task.id == id).toDomainModel());
  }

  @override
  Future delete(int id) {
    return Future.delayed(const Duration(milliseconds: 200), () => null);
  }

  @override
  Future<int> size() => Future.delayed(const Duration(milliseconds: 200), () => _tasksDatasource.length);

  @override
  Future<int> saveTask(Task task) {
    _tasksDatasource.add(TaskEntity.fromDomainModel(task));
    return Future.delayed(const Duration(milliseconds: 200), () => task.id);
  }

  @override
  void saveTasks(List<Task> tasks) {
    tasks.forEach((task) {
      saveTask(task);
    });
    final chosenTasksIds = tasks.where((task) => task.isChecked).map((task) => task.id).toList();
    log.i(message: "Tasks saved. Chosen tasks from them are: $chosenTasksIds");
  }
}
