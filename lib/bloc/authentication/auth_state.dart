part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitialState extends AuthState {
  final bool isPasswordViewActive;
  final String emailText;
  final String passwordText;

  AuthInitialState({isPasswordViewActive, emailText, passwordText})
  : isPasswordViewActive = isPasswordViewActive ?? true,
  emailText = emailText ?? "",
  passwordText = passwordText ?? "";

  @override
  List<Object?> get props => [isPasswordViewActive, emailText, passwordText];
}

class AuthLoadingState extends AuthState {

  @override
  List<Object?> get props => [];
}

class AuthLoggedInState extends AuthState {
  final UserModel userModel;

  AuthLoggedInState({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class AuthErrorState extends AuthState {
  final String errorMessage;

  AuthErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
