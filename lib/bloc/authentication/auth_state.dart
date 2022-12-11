part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitialState extends AuthState {
  final bool isPasswordViewActive;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  AuthInitialState({isPasswordViewActive, emailController, passwordController})
  : isPasswordViewActive = isPasswordViewActive ?? true,
        emailController = emailController ?? TextEditingController(),
        passwordController = passwordController ?? TextEditingController();

  AuthInitialState copywith({isPasswordViewActive, emailController, passwordController}) {
    return AuthInitialState(
      isPasswordViewActive: isPasswordViewActive ?? this.isPasswordViewActive,
        emailController: emailController ?? this.emailController,
        passwordController: passwordController ?? this.passwordController
    );
  }

  @override
  List<Object?> get props => [isPasswordViewActive, emailController, passwordController];
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
