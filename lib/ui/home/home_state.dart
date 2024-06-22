part of 'home_cubit.dart';

class HomeState extends Equatable {
  final UserLocal? userLocal;
  final List<Categories> categories;
  final List<TaskEntity> tasks;
  final List<List<TaskEntity>> taskByCategory;

  const HomeState({
    this.userLocal,
    this.categories = const [],
    this.tasks = const [],
    this.taskByCategory = const [],
  });

  @override
  List<Object?> get props => [
        userLocal,
        categories,
        tasks,
        taskByCategory,
      ];

  HomeState copyWith({
    UserLocal? userLocal,
    List<Categories>? categories,
    List<TaskEntity>? tasks,
    List<List<TaskEntity>>? taskByCategory,
  }) {
    return HomeState(
      userLocal: userLocal ?? this.userLocal,
      categories: categories ?? this.categories,
      tasks: tasks ?? this.tasks,
      taskByCategory: taskByCategory ?? this.taskByCategory,
    );
  }
}
