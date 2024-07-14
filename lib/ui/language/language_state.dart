part of 'language_cubit.dart';

class LanguageState extends Equatable {
  final Locale? currentLocal;

  const LanguageState({
    this.currentLocal,
  });

  @override
  List<Object?> get props => [
    currentLocal,
      ];

  LanguageState copyWith({
    final Locale? currentLocal,
  }) {
    return LanguageState(
      currentLocal: currentLocal ?? this.currentLocal,
    );
  }
}
