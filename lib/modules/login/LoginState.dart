import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginStates {}

class InitLoginState extends LoginStates {}

class ChangePassword extends LoginStates {}

class LoadingLogIn extends LoginStates {}

class SuccessLogIn extends LoginStates {
  final String uId;
  SuccessLogIn(this.uId);
}

class ErrorLogIn extends LoginStates {
  final FirebaseAuthException error;
  ErrorLogIn({required this.error});
}
// class LoadingLogIn extends LoginStates{}
