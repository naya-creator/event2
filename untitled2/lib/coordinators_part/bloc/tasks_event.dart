part of 'tasks_bloc.dart';

sealed class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class GetPendingTasks extends TasksEvent {}

class GetNonPendingTasks extends TasksEvent {}

class AcceptTask extends TasksEvent {
  final int task_id;
  final bool type;

  const AcceptTask(this.task_id, this.type);
  @override
  List<Object> get props => [task_id];
}

class RejectTask extends TasksEvent {
  final int task_id;
  final bool type;

  const RejectTask(this.task_id, this.type);
  @override
  List<Object> get props => [task_id];
}
