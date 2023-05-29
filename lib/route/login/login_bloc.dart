import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dipterv/core/locator.dart';
import 'package:dipterv/services/login_service.dart';
import 'package:dipterv/services/safe_storage_service.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _loginService = locator.get<LoginService>();
  final _safeStorageService = locator.get<SafeStoreService>();

  LoginBloc() : super(LoginLoadState()) {
    on<LoginInitEvent>(_loginInit);
    on<LoginPressedEvent>(_loginPressed);
  }

  Future<void> _loginInit(LoginInitEvent event, Emitter<LoginState> emit) async {
    if(await _safeStorageService.isUserAuthorized) {
      emit(LoginSuccessState());
      return;
    }
    emit(LoginBasicState());
  }

  Future<void> _loginPressed(LoginPressedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadState());
    try {
      var token = await _loginService.login(event.userName, event.password);
      await _safeStorageService.saveToken(token);
      await _safeStorageService.saveUsername(event.userName);
      await _safeStorageService.savePassword(event.password);
      emit(LoginSuccessState());
    } catch (e, stackTrace) {
      if(e is DioError) {
        emit(LoginBasicState(error: e.response?.data.toString()));
      }
    }
  }

}
