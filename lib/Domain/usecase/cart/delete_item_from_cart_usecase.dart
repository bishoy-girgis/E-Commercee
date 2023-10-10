import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Data/models/cart/get_cart_model.dart';

import '../../repositries/cart/cart_repositorty.dart';

class DeleteItemFromCartUseCase{
  CartRepository cartRepository;
  DeleteItemFromCartUseCase(this.cartRepository);
  Future<Either<Failure,GetCartModel>> execute(String id)=>cartRepository.deleteItemFromCart(id);
}