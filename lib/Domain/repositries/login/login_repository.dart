import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Core/services/user.dart';
import '../../entity/login/forgot_password_entity.dart';

abstract class LoginRepository{

  Future<Either<Failure, User >> login (String userName,String password);
  Future<Either<Failure, ForgotPasswordEntity>> forgotPassword (String email);
}