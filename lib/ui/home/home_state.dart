part of 'home_cubit.dart';

class HomeState extends Equatable {
  final UserLocal? userLocal;
  final List<Categories> categories;
  final List<TaskEntity> tasksProgress;
  final List<TaskEntity> tasksComplete;
  final List<List<TaskEntity>> taskByCategory;

  const HomeState({
    this.userLocal,
    this.categories = const [],
    this.tasksProgress = const [],
    this.taskByCategory = const [],
    this.tasksComplete = const [],
  });

  @override
  List<Object?> get props => [
        userLocal,
        categories,
        tasksProgress,
        taskByCategory,
        tasksComplete,
      ];

  HomeState copyWith({
    UserLocal? userLocal,
    List<Categories>? categories,
    List<TaskEntity>? tasksProgress,
    List<List<TaskEntity>>? taskByCategory,
    List<TaskEntity>? tasksComplete,
  }) {
    return HomeState(
      userLocal: userLocal ?? this.userLocal,
      categories: categories ?? this.categories,
      tasksProgress: tasksProgress ?? this.tasksProgress,
      taskByCategory: taskByCategory ?? this.taskByCategory,
      tasksComplete: tasksComplete ?? this.tasksComplete,
    );
  }
}
