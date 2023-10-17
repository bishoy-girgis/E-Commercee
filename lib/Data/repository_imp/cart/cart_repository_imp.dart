import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Data/data_sources/cart/cart_data_source.dart';
import 'package:e_commerce_app/Data/models/home/cart_response_model.dart';
import 'package:e_commerce_app/Domain/repositries/cart/cart_repositorty.dart';

import '../../models/cart/clear_cart_model.dart';
import '../../models/cart/get_cart_model.dart';

class CartRepositoryImp implements CartRepository {
  CartDataSource cartDataSource;
  CartRepositoryImp(this.cartDataSource);
  @override
  Future<Either<Failure, GetCartModel>> getCart() {
    return cartDataSource.getCart();
  }

  @override
  Future<Either<Failure, GetCartModel>> deleteItemFromCart(String id) {
   return cartDataSource.deleteItemFromCart(id);
  }

  @override
  Future<Either<Failure, GetCartModel>> updateItemFromCart(String id, int count) {
    return cartDataSource.updateItemFromCart(id, count);
  }

  @override
  Future<Either<Failure, ClearCartModel>> clearCart() {
    return cartDataSource.clearCart();
  }

}