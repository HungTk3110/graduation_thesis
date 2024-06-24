part of 'search_cubit.dart';

class SearchState extends Equatable {
  final LoadStatus loadStatus;
  final List<TaskEntity> tasks;

  const SearchState({
    this.loadStatus = LoadStatus.init,
    this.tasks = const [],
  });

  @override
  List<Object?> get props => [
        loadStatus,
        tasks,
      ];

  SearchState copyWith({
    final LoadStatus? loadStatus,
    final List<TaskEntity>? tasks,
  }) {
    return SearchState(
      loadStatus: loadStatus ?? this.loadStatus,
      tasks: tasks ?? this.tasks,
    );
  }
}
