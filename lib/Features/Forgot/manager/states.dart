import '../../../Core/error/faliure.dart';
import '../../../Domain/entity/login/forgot_password_entity.dart';

abstract class ForgotStates{}
class ForgotInitState extends ForgotStates {}

class ForgotLoadingState extends ForgotStates {}

class ForgotSuccessState extends ForgotStates {
  ForgotPasswordEntity forgotPasswordEntity;

  ForgotSuccessState(this.forgotPasswordEntity);
}

class ForgotErrorState extends ForgotStates {
  Failure failure;

  ForgotErrorState(this.failure);
}
