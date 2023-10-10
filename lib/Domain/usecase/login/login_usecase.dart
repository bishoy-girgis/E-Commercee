import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Core/services/user.dart';
import 'package:e_commerce_app/Domain/repositries/login/login_repository.dart';

class LoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase(this.loginRepository);

  Future<Either<Failure, User>> excute(String userName, String password) async {
    return await loginRepository.login(userName, password);
  }
}
