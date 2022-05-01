import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterStates {}

class InitRegisterState extends RegisterStates {}

class ChangeRegisterPassword extends RegisterStates {}

class LoadingRegister extends RegisterStates {}

class SuccessRegister extends RegisterStates {}

class ErrorRegister extends RegisterStates {
  final FirebaseAuthException error;
  ErrorRegister({required this.error});
}
// class LoadingLogIn extends RegisterStates{}

class LoadingCreateRegister extends RegisterStates {}

class SuccessCreateRegister extends RegisterStates {
  final String uId;
  SuccessCreateRegister(this.uId);
}

class ErrorCreateRegister extends RegisterStates {
  final FirebaseAuthException error;
  ErrorCreateRegister({required this.error});
}
