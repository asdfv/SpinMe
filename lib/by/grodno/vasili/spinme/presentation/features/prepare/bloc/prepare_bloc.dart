import 'package:domain/domain_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_event.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_state.dart';

class PrepareBloc extends Bloc<PrepareEvent, PrepareState> {
  final PrepareCoordinator coordinator;

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
    } else if (event is TasksChosen) {
      coordinator.saveTasks(event.tasks);
    } else if (event is TaskEdited) {
      final updatedTask = event.newTask;
      if (event.oldTask.description != updatedTask.description) {
        coordinator.saveTask(updatedTask);
        final List<Task> newList = List.from(state.tasks!);
        final index = newList.indexWhere((element) => element.id == updatedTask.id);
        newList[index] = updatedTask;
        yield state.copyWith(tasks: newList);
      }
    }
  }
}
