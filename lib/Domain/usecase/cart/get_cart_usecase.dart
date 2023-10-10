import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Data/models/home/cart_response_model.dart';
import 'package:e_commerce_app/Domain/repositries/cart/cart_repositorty.dart';

import '../../../Data/models/cart/get_cart_model.dart';

class GetCartUseCase{
  CartRepository cartRepository;
  GetCartUseCase(this.cartRepository);
  Future<Either<Failure, GetCartModel>>execute()=> cartRepository.getCart();
}