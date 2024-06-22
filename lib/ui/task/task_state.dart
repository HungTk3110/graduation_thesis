part of 'task_cubit.dart';

class TaskState extends Equatable {
  final TaskEntity? taskEntity;
  final bool doneTask;

  const TaskState({
    this.taskEntity,
    this.doneTask = false,
  });

  @override
  List<Object?> get props => [
        taskEntity,
        doneTask,
      ];

  TaskState copyWith({
    final TaskEntity? taskEntity,
    final bool? doneTask,
  }) {
    return TaskState(
      taskEntity: taskEntity ?? this.taskEntity,
      doneTask: doneTask ?? this.doneTask,
    );
  }
}
