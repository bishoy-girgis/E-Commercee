import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Data/models/cart/get_cart_model.dart';
import 'package:e_commerce_app/Domain/repositries/cart/cart_repositorty.dart';
import 'package:e_commerce_app/Domain/repositries/home/home_repository.dart';

class UpdateCartUseCase {
  CartRepository cartRepository;

  UpdateCartUseCase(this.cartRepository);

  Future<Either<Failure, GetCartModel>> execute(String id, int count) =>
      cartRepository.updateItemFromCart(id, count);
}
