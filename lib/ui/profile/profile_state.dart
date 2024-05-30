part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final UserLocal? userLocal;
  final File? fileAvatar;
  final String? filePath;

  const ProfileState({
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

  ProfileState copyWith({
    final UserLocal? userLocal,
    final File? fileAvatar,
    final String? filePath,
  }) {
    return ProfileState(
      userLocal: userLocal ?? this.userLocal,
      fileAvatar: fileAvatar ?? this.fileAvatar,
      filePath: filePath ?? this.filePath,
    );
  }
}
