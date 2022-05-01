import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/constants.dart';
import 'LoginState.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitLoginState());
  static LoginCubit get(context) => BlocProvider.of(context);
  bool isHidePassword = true;
  IconData password = Icons.visibility_outlined;

  void changePassword() {
    isHidePassword = !isHidePassword;
    password = isHidePassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePassword());
  }

  void UserLogin({required String email, required String password}) {
    emit(LoadingLogIn());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      uId = value.user!.uid;
      print(value.user!.uid);
      emit(SuccessLogIn(value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorLogIn(error: error));
    });
  }
}
