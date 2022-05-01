import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialkom/models/CreateUser.dart';
import 'package:socialkom/modules/Register/registerState.dart';

import '../../shared/components/constants.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitRegisterState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool isHidePassword = true;
  IconData password = Icons.visibility_outlined;

  void changePassword() {
    isHidePassword = !isHidePassword;
    password = isHidePassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangeRegisterPassword());
  }

  void UserRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(LoadingRegister());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      uId = value.user!.uid;
      UserCreate(email: email, name: name, phone: phone, uId: value.user!.uid);
    }).catchError((err) {
      print(err.toString());
      emit(ErrorRegister(error: err));
    });
  }

  void UserCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    UserModel createUserModel = UserModel(
        uId: uId,
        name: name,
        email: email,
        phone: phone,
        EmailVerified: false,
        post: 0,
        image:
            "https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png",
        background:
            "https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png",
        bio: "write your bio ....",
        theme: true);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(createUserModel.toMap())
        .then((value) {
      // FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(uId)
      //     .collection('notification')
      //     .add({}).then((value) => null);
      emit(SuccessCreateRegister(uId));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorCreateRegister(error: error));
    });
  }
}
