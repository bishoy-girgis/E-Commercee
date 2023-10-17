import 'package:dartz/dartz.dart';

import '../../../Core/error/faliure.dart';
import '../../../Data/models/cart/clear_cart_model.dart';
import '../../../Data/models/cart/get_cart_model.dart';
import '../../repositries/cart/cart_repositorty.dart';

class ClearCartUseCase{
  late CartRepository cartRepository;
  ClearCartUseCase(this.cartRepository);
  Future<Either<Failure, ClearCartModel>>execute()=> cartRepository.clearCart();
}