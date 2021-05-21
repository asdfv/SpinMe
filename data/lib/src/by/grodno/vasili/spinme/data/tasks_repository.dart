import 'package:domain/domain_module.dart';

class FakeTasksRepository extends TasksRepository {
  final List<String> _tasks = List.generate(30, (index) => 'Task number $index');

  @override
  Future<List<String>> getAllTasks() async {
    return Future.delayed(const Duration(milliseconds: 200), () => _tasks);
  }

  @override
  Future<String?> getOne(int index) {
    if (index > _tasks.length - 1) {
      return Future.delayed(const Duration(milliseconds: 200), () => null);
    } else {
      return Future.delayed(const Duration(milliseconds: 200), () => _tasks[index]);
    }
  }

  @override
  Future delete(int index) {
    return Future.delayed(const Duration(milliseconds: 200), () => null);
  }

  @override
  Future<int> size() => Future.delayed(const Duration(milliseconds: 200), () => _tasks.length);
}
