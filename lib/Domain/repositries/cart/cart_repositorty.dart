import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';

import '../../../Data/models/cart/clear_cart_model.dart';
import '../../../Data/models/cart/get_cart_model.dart';

abstract class CartRepository{
  Future<Either<Failure,GetCartModel>> getCart();
  Future<Either<Failure,ClearCartModel>> clearCart();
  Future<Either<Failure,GetCartModel>> deleteItemFromCart(String id);
  Future<Either<Failure,GetCartModel>> updateItemFromCart(String id,int count);
}