import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Data/models/home/cart_response_model.dart';
import 'package:e_commerce_app/Domain/repositries/home/home_repository.dart';

class AddCartUseCase {
  HomeRepository homeRepository;
  AddCartUseCase(this.homeRepository);

  Future<Either<Failure, CartResponseModel>> execute(String productId)=>homeRepository.addToCart(productId);
}