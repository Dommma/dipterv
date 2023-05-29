part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileInitEvent extends ProfileEvent {}

class ProfileLogoutEvent extends ProfileEvent {
  final Future<bool> Function() showDialog;

  ProfileLogoutEvent({required this.showDialog});
}
