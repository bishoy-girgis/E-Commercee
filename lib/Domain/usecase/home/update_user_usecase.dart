import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Domain/entity/home/update_user_entity.dart';
import 'package:e_commerce_app/Domain/repositries/home/home_repository.dart';

class UpdateUserUseCase {
  HomeRepository homeRepository;

  UpdateUserUseCase(this.homeRepository);

  Future<Either<Failure, UpdateUserEntity>> execute(
          {required String name,
          required String email,
          required String phone}) =>
      homeRepository.updateUser(name, email, phone);
}
