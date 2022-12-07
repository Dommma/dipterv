import 'package:bloc/bloc.dart';
import 'package:dipterv/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial(isPasswordViewActive: false));

  void changePasswordView() {

  }
}
