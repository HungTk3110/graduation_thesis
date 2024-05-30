part of 'user_authentication_cubit.dart';

class UserAuthenticationState extends Equatable {
  final AuthenticationType authenticationType;
  final bool validateContentLogin;
  final bool validateContentSignUp;

  const UserAuthenticationState({
    this.authenticationType = AuthenticationType.login,
    this.validateContentLogin = false,
    this.validateContentSignUp = false,
  });

  @override
  List<Object?> get props => [
        authenticationType,
        validateContentLogin,
        validateContentSignUp,
      ];

  UserAuthenticationState copyWith({
    final AuthenticationType? authenticationType,
    final bool? validateContentLogin,
    final bool? validateContentSignUp,
  }) {
    return UserAuthenticationState(
      authenticationType: authenticationType ?? this.authenticationType,
      validateContentLogin: validateContentLogin ?? this.validateContentLogin,
      validateContentSignUp:
          validateContentSignUp ?? this.validateContentSignUp,
    );
  }
}
