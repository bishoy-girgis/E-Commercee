import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Data/models/signup/signup_request.dart';
import 'package:e_commerce_app/Domain/repositries/signup/signup_repository.dart';

import '../../../Core/error/faliure.dart';
import '../../entity/signup/sign_up_entity.dart';

class SignUpUseCase {
  final SignUpRepository _signUpRepository;

  SignUpUseCase(this._signUpRepository);

  Future<Either<Failure, SignUpEntity>> excute(SignUpRequestModel data) async {
    return await _signUpRepository.signUp(data);
  }
}
