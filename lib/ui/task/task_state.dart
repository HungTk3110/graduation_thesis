part of 'task_cubit.dart';

class TaskState extends Equatable {
  final TaskEntity? taskEntity;

  const TaskState({
    this.taskEntity,
  });

  @override
  List<Object?> get props => [
        taskEntity,
      ];

  TaskState copyWith({
    final TaskEntity? taskEntity,
  }) {
    return TaskState(
      taskEntity: taskEntity ?? this.taskEntity,
    );
  }
}
