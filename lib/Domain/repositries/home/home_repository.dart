import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Domain/entity/home/add_wishlist_entity.dart';
import 'package:e_commerce_app/Domain/entity/home/category_entity.dart';
import 'package:e_commerce_app/Domain/entity/home/delete_wishlist_entity.dart';
import 'package:e_commerce_app/Domain/entity/home/get_wishlist_entity.dart';
import 'package:e_commerce_app/Domain/entity/home/product_entity.dart';
import 'package:e_commerce_app/Domain/usecase/home/add_wishlist_usecase.dart';

import '../../../Data/models/home/add_address_model.dart';
import '../../../Data/models/home/cart_response_model.dart';
import '../../entity/home/update_user_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, CategoryOrBrandEntity>> getCategories();

  Future<Either<Failure, CategoryOrBrandEntity>> getBrands();

  Future<Either<Failure, ProductEntity>> getProducts();

  Future<Either<Failure, CartResponseModel>> addToCart(String productId);

  Future<Either<Failure, AddWishlistEntity>> addToWishList(String productId);
  Future<Either<Failure, GetWishlistEntity>> getWishList();
  Future<Either<Failure, DeleteWishlistEntity>> deleteWishList(String productId);

  Future<Either<Failure ,UpdateUserEntity>> updateUser(String name,String email,String phone);
  Future<Either<Failure,AddAddressModel >> addAddress(String name,String details,String city);
}
