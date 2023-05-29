part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginBasicState extends LoginState {
  String? error;

  LoginBasicState({this.error});
}

class LoginLoadState extends LoginState {}

class LoginSuccessState extends LoginState {}

