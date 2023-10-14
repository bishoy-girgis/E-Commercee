
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';

import 'package:e_commerce_app/Domain/repositries/login/login_repository.dart';

import '../../entity/login/forgot_password_entity.dart';


class ForgotPasswordUseCase{
  LoginRepository loginRepository;
  ForgotPasswordUseCase(this.loginRepository);
  Future<Either<Failure,ForgotPasswordEntity>>execute(String email)=>loginRepository.forgotPassword(email);
}