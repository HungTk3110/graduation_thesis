part of 'category_cubit.dart';

class CategoryState extends Equatable {
  final UserLocal? userLocal;
  final File? fileAvatar;
  final String? filePath;

  const CategoryState({
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

  CategoryState copyWith({
    final UserLocal? userLocal,
    final File? fileAvatar,
    final String? filePath,
  }) {
    return CategoryState(
      userLocal: userLocal ?? this.userLocal,
      fileAvatar: fileAvatar ?? this.fileAvatar,
      filePath: filePath ?? this.filePath,
    );
  }
}
