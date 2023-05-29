import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dipterv/core/locator.dart';
import 'package:dipterv/models/salesman_model.dart';
import 'package:dipterv/services/safe_storage_service.dart';
import 'package:dipterv/services/salesman_service.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final _salesmanService = locator.get<SalesmanService>();
  final _safeStorageService = locator.get<SafeStoreService>();

  ProfileBloc() : super(ProfileLoadingState()) {
    on<ProfileInitEvent>(_initEvent);
    on<ProfileLogoutEvent>(_logoutEvent);
  }

  Future<void> _initEvent(ProfileInitEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoadingState());
      var email = await _safeStorageService.username;
      var salesman = await _salesmanService.getChosenSalesman(email!);
      emit(ProfileBasicState(profile: salesman));
    } catch (e, stackTrace) {
      if(e is DioError) {
        emit(ProfileBasicState(error: e.response?.data));
      }
    }
  }

  Future<void> _logoutEvent(ProfileLogoutEvent event, Emitter<ProfileState> emit) async {
    final isAccepted = await event.showDialog();
    if(!isAccepted) {
      return;
    }
    await _safeStorageService.removePassword();
    await _safeStorageService.removeToken();
    await _safeStorageService.removeUsername();
    emit(ProfileLogoutState());
  }
}
