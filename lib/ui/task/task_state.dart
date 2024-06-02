part of 'task_cubit.dart';

class TaskState extends Equatable {
  final UserLocal? userLocal;
  final File? fileAvatar;
  final String? filePath;

  const TaskState({
    this.userLocal,
    this.fileAvatar,
    this.filePath,
  });

  @override
  List<Object?> get props => [
        userLocal,
    fileAvatar,
        filePath,
      ];

  TaskState copyWith({
    final UserLocal? userLocal,
    final File? fileAvatar,
    final String? filePath,
  }) {
    return TaskState(
      userLocal: userLocal ?? this.userLocal,
      fileAvatar: fileAvatar ?? this.fileAvatar,
      filePath: filePath ?? this.filePath,
    );
  }
}
