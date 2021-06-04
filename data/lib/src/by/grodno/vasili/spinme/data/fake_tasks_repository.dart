import 'package:data/src/by/grodno/vasili/spinme/data/models/task_entity.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/utilities/utilities.dart';
import 'package:domain/domain_module.dart';

class FakeTasksRepository extends TasksRepository {
  final log = getLogger();

  final Map<int, TaskEntity> _tasksDatasource = {
    0: TaskEntity(0, 'Dance jiga dryga', true),
    1: TaskEntity(1, 'Drink 0.5L of water', true),
    2: TaskEntity(2, 'Tell any tongue-twister 10 times', true),
    3: TaskEntity(3, 'Do 10 somersaults', true),
    4: TaskEntity(4, 'Squeeze out 20 times', true),
    5: TaskEntity(5, 'Sing a song in English', true),
    6: TaskEntity(6, 'Tell the fictional story about photo in your phone', true),
    7: TaskEntity(7, 'Show double biceps in front', false),
  };

  @override
  Future<List<Task>> getAllTasks() async {
    return runDelayed(() => _tasksDatasource.values.map((e) => e.toDomainModel()).toList());
  }

  @override
  Future<Task?> getOne(int id) {
    return runDelayed(() => _tasksDatasource.values.firstWhere((task) => task.id == id).toDomainModel());
  }

  @override
  Future delete(int id) {
    return runDelayed(() => null);
  }

  @override
  Future<int> size() => Future.delayed(const Duration(milliseconds: 200), () => _tasksDatasource.length);

  @override
  Future<int> saveTask(Task task) {
    _tasksDatasource[task.id] = TaskEntity.fromDomainModel(task);
    return runDelayed(() => task.id);
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
