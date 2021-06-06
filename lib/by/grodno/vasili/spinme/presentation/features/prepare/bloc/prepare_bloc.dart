import 'package:domain/domain_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_event.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_state.dart';

class PrepareBloc extends Bloc<PrepareEvent, PrepareState> {
  final PrepareCoordinator coordinator;
  final log = getLogger();

  PrepareBloc(PrepareState initialState, this.coordinator) : super(initialState);

  @override
  Stream<PrepareState> mapEventToState(PrepareEvent event) async* {
    if (event is LoadTasks) {
      yield state.copyWith(isLoading: true);
      final tasks = await coordinator.getAllTasks();
      yield state.copyWith(isLoading: false, tasks: tasks);
    } else if (event is NamesChosen) {
      final List<Player> players = event.names.asMap().entries.map((entry) => Player(entry.key, entry.value)).toList();
      coordinator.replaceAllPlayers(players);
      log.d(message: "${players.length} players replaced.");
    } else if (event is TasksChosen) {
      var tasks = event.tasks;
      coordinator.saveTasks(tasks);
      log.d(message: "${tasks.length} tasks are saved.");
    } else if (event is TaskEdited) {
      final updatedTask = event.newTask;
        coordinator.saveTask(updatedTask);
        final List<Task> newList = List.from(state.tasks!);
        final index = newList.indexWhere((element) => element.id == updatedTask.id);
        newList[index] = updatedTask;
        yield state.copyWith(tasks: newList);
    } else if (event is DeleteTask) {
      final idToRemove = event.id;
      coordinator.deleteTask(idToRemove);
      final List<Task> newList = List.from(state.tasks!);
      newList.removeWhere((task) {
        log.d(message: "Task $task deleted.");
        return task.id == idToRemove;
      });
      yield state.copyWith(tasks: newList);
    } else if (event is LoadPlayers) {
      yield state.copyWith(isLoading: true);
      final players = await coordinator.getAllPlayers();
      yield state.copyWith(players: players, isLoading: false);
    }
  }
}
