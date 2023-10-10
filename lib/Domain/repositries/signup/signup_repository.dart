import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Domain/entity/signup/sign_up_entity.dart';

import '../../../Data/models/signup/signup_request.dart';

abstract class SignUpRepository {

  Future<Either<Failure,SignUpEntity>> signUp(SignUpRequestModel data);
}