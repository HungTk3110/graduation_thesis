part of 'home_cubit.dart';

class HomeState extends Equatable {
  final UserLocal? userLocal;

   const HomeState({
    this.userLocal,
  });

  @override
  List<Object?> get props => [
    userLocal,
      ];

  HomeState copyWith({
    final UserLocal? userLocal,
  }) {
    return HomeState(
      userLocal: userLocal ?? this.userLocal,
    );
  }
}
