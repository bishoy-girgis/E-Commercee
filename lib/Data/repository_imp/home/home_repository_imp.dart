import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Data/data_sources/home/home_datasource.dart';
import 'package:e_commerce_app/Data/models/home/add_address_model.dart';
import 'package:e_commerce_app/Data/models/home/cart_response_model.dart';
import 'package:e_commerce_app/Data/models/home/update_user_model.dart';
import 'package:e_commerce_app/Domain/entity/home/add_wishlist_entity.dart';
import 'package:e_commerce_app/Domain/entity/home/category_entity.dart';
import 'package:e_commerce_app/Domain/entity/home/delete_wishlist_entity.dart';
import 'package:e_commerce_app/Domain/entity/home/get_wishlist_entity.dart';
import 'package:e_commerce_app/Domain/entity/home/product_entity.dart';
import 'package:e_commerce_app/Domain/entity/home/update_user_entity.dart';
import 'package:e_commerce_app/Domain/repositries/home/home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  HomeDataSource homeDataSource;

  HomeRepositoryImp(this.homeDataSource);

  @override
  Future<Either<Failure, CategoryOrBrandEntity>> getBrands() {
    return homeDataSource.getBrands();
  }

  @override
  Future<Either<Failure, CategoryOrBrandEntity>> getCategories() {
    return homeDataSource.getCategories();
  }

  @override
  Future<Either<Failure, ProductEntity>> getProducts() {
    return homeDataSource.getProducts();
  }

  @override
  Future<Either<Failure, CartResponseModel>> addToCart(String productId) {
    return homeDataSource.addToCart(productId);
  }

  @override
  Future<Either<Failure, AddWishlistEntity>> addToWishList(String productId) {
   return homeDataSource.addToWishList(productId);
  }

  @override
  Future<Either<Failure, GetWishlistEntity>> getWishList() {
   return homeDataSource.getWishList();
  }

  @override
  Future<Either<Failure, DeleteWishlistEntity>> deleteWishList(String productId) {
   return homeDataSource.deleteWishList(productId);
  }

  @override
  Future<Either<Failure, UpdateUserModel>> updateUser(String name, String email, String phone) {
   return homeDataSource.updateUser(name, email, phone);
  }

  @override
  Future<Either<Failure, AddAddressModel>> addAddress(String name, String details, String city) {
    return homeDataSource.addAddress(name, details, city);
  }


}
