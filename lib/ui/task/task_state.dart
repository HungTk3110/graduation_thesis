part of 'task_cubit.dart';

class TaskState extends Equatable {
  final TaskEntity? taskEntity;
  final bool doneTask;
  final List<File> listFile;

  const TaskState({
    this.taskEntity,
    this.doneTask = false,
    this.listFile = const [],
  });

  @override
  List<Object?> get props => [
        taskEntity,
        doneTask,
        listFile,
      ];

  TaskState copyWith({
    final TaskEntity? taskEntity,
    final bool? doneTask,
    final List<File>? listFile,
  }) {
    return TaskState(
      taskEntity: taskEntity ?? this.taskEntity,
      doneTask: doneTask ?? this.doneTask,
      listFile: listFile ?? this.listFile,
    );
  }
}
