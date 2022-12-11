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
      emit(state.copywith(isPasswordViewActive: !state.isPasswordViewActive));
    }
  }

  void loginUser() async {
    var state = this.state;
    emit(AuthLoadingState());
    try {
      if(state is AuthInitialState) {
        if(state.emailController.text.isEmpty || state.passwordController.text.isEmpty) {
          emit(AuthErrorState(errorMessage: "Don't leave the input fields empty!"));
          emit(AuthInitialState(isPasswordViewActive: true, emailController: state.emailController));
          return;
        }
        await pocketBase.collection('users').authWithPassword(state.emailController.text, state.passwordController.text);
      }
      final record = await pocketBase.collection('users').getOne(pocketBase.authStore.model.id);
      final UserModel currentUser = UserModel.fromJson(record.toJson());
      emit(AuthLoggedInState(userModel: currentUser));
    } on Exception catch (e) {
      emit(AuthErrorState(errorMessage: "Bad email, username or password"));
      if(state is AuthInitialState) {
        emit(AuthInitialState(isPasswordViewActive: true, emailController: state.emailController));
      }
    }
  }

  void nameChanged() {
    var state = this.state;
    if(state is AuthInitialState) {
      TextEditingController tec = state.emailController;
      tec.selection =
          TextSelection.collapsed(offset: tec.text.length);
      emit(state.copywith(emailController: tec));
    }
  }

  void passwordChanged() {
    var state = this.state;
    if(state is AuthInitialState) {
      TextEditingController tec = state.passwordController;
      tec.selection =
          TextSelection.collapsed(offset: tec.text.length);
      emit(state.copywith(passwordController: tec));
    }
  }

  void logoutUser() {
    var state = this.state;
    if(state is AuthLoggedInState) {
      emit(AuthInitialState(isPasswordViewActive: true, emailController: TextEditingController(text: state.userModel.email)));
      pocketBase.authStore.clear();
    }
  }
}
