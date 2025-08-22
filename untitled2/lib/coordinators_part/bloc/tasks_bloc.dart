

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/tasks_repoitory.dart';
import 'models/non-pending_task_model.dart';
import 'models/tasks_data_model.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksLoading()) {
    on<GetPendingTasks>((event, emit) async {
      emit(TasksLoading());
      try {
        List<PendingData> tasks = await TasksRepository.getPendingTasks();
        emit(TasksLoaded(tasks));
      } catch (e) {
        emit(TasksError("Error:$e"));
      }
    });

    on<GetNonPendingTasks>((event, emit) async {
      emit(TasksLoading());
      try {
        List<NonPendingData> tasks2 =
            await TasksRepository.getNonPendingTasks();
        emit(NonPengingTasksLoaded(tasks2));
      } catch (e) {
        emit(TasksError("Error:$e"));
      }
    });

    on<AcceptTask>((event, emit) async {
      emit(TasksLoading());
      try {
        bool done = await TasksRepository.changeStatusTask(
          event.task_id,
          true, // ✅ قبول
        );
        if (done) {
          List<PendingData> updatedTasks =
              await TasksRepository.getPendingTasks();
          emit(TaskActionSuccess("تم قبول المهمة بنجاح"));
          emit(TasksLoaded(updatedTasks));
        } else {
          emit(TasksError("فشل في تحديث الحالة"));
        }
      } catch (e) {
        emit(TasksError("Error:$e"));
      }
    });

    on<RejectTask>((event, emit) async {
      emit(TasksLoading());
      try {
        bool done = await TasksRepository.changeStatusTask(
          event.task_id,
          false, // ✅ رفض
        );
        if (done) {
          List<PendingData> updatedTasks =
              await TasksRepository.getPendingTasks();
          emit(TaskActionSuccess("تم رفض المهمة بنجاح"));
          emit(TasksLoaded(updatedTasks));
        } else {
          emit(TasksError("فشل في تحديث الحالة"));
        }
      } catch (e) {
        emit(TasksError("Error:$e"));
      }
    });
  }
}
