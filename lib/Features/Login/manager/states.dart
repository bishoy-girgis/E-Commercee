import '../../../Core/error/faliure.dart';
import '../../../Core/services/user.dart';

abstract class LoginStates {}

class LoginInitState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  User user;
  LoginSuccessState(this.user);
}

class LoginErrorState extends LoginStates {
  Failure failure;

  LoginErrorState(this.failure);
}
