part of 'search_cubit.dart';

class SearchState extends Equatable {
  final UserLocal? userLocal;
  final File? fileAvatar;
  final String? filePath;

  const SearchState({
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

  SearchState copyWith({
    final UserLocal? userLocal,
    final File? fileAvatar,
    final String? filePath,
  }) {
    return SearchState(
      userLocal: userLocal ?? this.userLocal,
      fileAvatar: fileAvatar ?? this.fileAvatar,
      filePath: filePath ?? this.filePath,
    );
  }
}
