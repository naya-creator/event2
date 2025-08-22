part of 'tasks_bloc.dart';

sealed class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

final class TasksLoading extends TasksState {}

final class TasksLoaded extends TasksState {
  final List<PendingData> tasks;
  const TasksLoaded(this.tasks);
  @override
  List<Object> get props => [tasks];
}

final class NonPengingTasksLoaded extends TasksState {
  final List<NonPendingData> tasks;
  const NonPengingTasksLoaded(this.tasks);
  @override
  List<Object> get props => [tasks];
}

final class TasksError extends TasksState {
  final String masseg;
  const TasksError(this.masseg);
  @override
  List<Object> get props => [masseg];
}

final class TaskActionSuccess extends TasksState {
  final String masseg;

  const TaskActionSuccess(this.masseg);
  @override
  List<Object> get props => [masseg];
}

