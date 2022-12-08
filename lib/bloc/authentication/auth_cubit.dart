import 'package:bloc/bloc.dart';
import 'package:dipterv/models/user_model.dart';
import 'package:dipterv/services/constans.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  void changePasswordView() {
    var state = this.state;
    if(state is AuthInitialState) {
      emit(AuthInitialState(isPasswordViewActive: !state.isPasswordViewActive, emailText: state.emailText, passwordText: state.passwordText));
    }
  }

  void changePasswordText(String newPasswordText) {
    var state = this.state;
    if(state is AuthInitialState) {
      emit(AuthInitialState(passwordText: newPasswordText, emailText: state.emailText, isPasswordViewActive: state.isPasswordViewActive));
    }
  }
  void changeUserText(String newUserText) {
    var state = this.state;
    if(state is AuthInitialState) {
      emit(AuthInitialState(emailText: newUserText, passwordText: state.passwordText, isPasswordViewActive: state.isPasswordViewActive));
    }
  }


  void loginUser(String userName, String password) async {
    var state = this.state;
    emit(AuthLoadingState());
    try {
      await pocketBase.collection('users').authWithPassword(userName, password);
      final record = await pocketBase.collection('users').getOne(pocketBase.authStore.model.id);
      final UserModel currentUser = UserModel.fromJson(record.toJson());
      emit(AuthLoggedInState(userModel: currentUser));
    } on Exception catch (e) {
      emit(AuthErrorState(errorMessage: "Bad email, username or password"));
      if(state is AuthInitialState) {
        emit(AuthInitialState(isPasswordViewActive: true, emailText: state.emailText));
      }
    }
  }

  void logoutUser() {
    emit(AuthInitialState(isPasswordViewActive: true));
  }
}
