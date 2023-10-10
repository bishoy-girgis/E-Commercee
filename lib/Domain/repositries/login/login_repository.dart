import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';

abstract class LoginRepository{

  Future<Either<Failure, bool >> login (String userName,String password);
}