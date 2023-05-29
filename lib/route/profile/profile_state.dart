part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileBasicState extends ProfileState {
  final SalesmanModel? profile;
  final String? error;

  ProfileBasicState({this.profile, this.error});
}

class ProfileLogoutState extends ProfileState {}
