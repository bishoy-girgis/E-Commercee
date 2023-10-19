import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Data/models/home/add_address_model.dart';
import 'package:e_commerce_app/Domain/repositries/home/home_repository.dart';

class AddAddressUseCase {
  HomeRepository homeRepository;

  AddAddressUseCase(this.homeRepository);

  Future<Either<Failure, AddAddressModel>> execute(
          {required String name,
          required String details,
          required String city}) =>
      homeRepository.addAddress(name, details, city);
}
