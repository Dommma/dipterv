part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginInitEvent extends LoginEvent {}

class LoginPressedEvent extends LoginEvent {
  String userName;
  String password;

  LoginPressedEvent({required this.userName, required this.password});
}
