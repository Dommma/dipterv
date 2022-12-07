part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  final bool isPasswordViewActive;

  AuthInitial({required this.isPasswordViewActive});

  @override
  List<Object?> get props => [isPasswordViewActive];
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
