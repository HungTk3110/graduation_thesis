part of 'home_cubit.dart';

class HomeState extends Equatable {
  final UserLocal? userLocal;
  final List<Categories> categories;

  const HomeState({
    this.userLocal,
    this.categories = const [],
  });

  @override
  List<Object?> get props => [
        userLocal,
        categories,
      ];

  HomeState copyWith({
    final UserLocal? userLocal,
    final List<Categories>? categories,
  }) {
    return HomeState(
      userLocal: userLocal ?? this.userLocal,
      categories: categories ?? this.categories,
    );
  }
}
