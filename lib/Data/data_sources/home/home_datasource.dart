import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/Core/constants/constants.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Data/models/home/add_wishlist_model.dart';
import 'package:e_commerce_app/Data/models/home/category_or_brand_model.dart';
import 'package:e_commerce_app/Data/models/home/delete_wishlist_model.dart';
import 'package:e_commerce_app/Data/models/home/get_wishlist_model.dart';
import 'package:e_commerce_app/Data/models/home/product_model.dart';
import 'package:e_commerce_app/Domain/entity/home/product_entity.dart';

import '../../../Core/services/cache_helper.dart';
import '../../models/home/cart_response_model.dart';

abstract class HomeDataSource {
  Future<Either<Failure, CategoryOrBrandModel>> getBrands();

  Future<Either<Failure, CategoryOrBrandModel>> getCategories();

  Future<Either<Failure, ProductModel>> getProducts();

  Future<Either<Failure, CartResponseModel>> addToCart(String productId);

  Future<Either<Failure, AddWishlistModel>> addToWishList(String id);

  Future<Either<Failure, GetWishlistModel>> getWishList();
  Future<Either<Failure, DeleteWishlistModel>> deleteWishList(String productId);
}

class HomeRemoteDto implements HomeDataSource {
  Dio dio = Dio();

  @override
  Future<Either<Failure, CategoryOrBrandModel>> getBrands() async {
    try {
      var response = await dio.get("${Constants.baseUrl}/api/v1/brands");
      CategoryOrBrandModel model = CategoryOrBrandModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(statusCode: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryOrBrandModel>> getCategories() async {
    try {
      var response = await dio.get("${Constants.baseUrl}/api/v1/categories");
      CategoryOrBrandModel model = CategoryOrBrandModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(statusCode: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getProducts() async {
    try {
      var response = await dio.get("${Constants.baseUrl}/api/v1/products");
      ProductModel model = ProductModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(statusCode: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartResponseModel>> addToCart(String productId) async {
    var userToken = CacheHelper.getData("user");
    try {
      var response = await dio.post(
        "${Constants.baseUrl}/api/v1/cart",
        options: Options(
          headers: {"token": userToken},
        ),
        data: {"productId": productId},
      );
      CartResponseModel model = CartResponseModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(statusCode: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddWishlistModel>> addToWishList(String id) async {
    var userToken = CacheHelper.getData("user");
    try {
      var response = await dio.post(
        "${Constants.baseUrl}/api/v1/wishlist",
        options: Options(
          headers: {"token": userToken},
        ),
        data: {"productId": id},
      );
      AddWishlistModel model = AddWishlistModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(statusCode: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetWishlistModel>> getWishList() async{
    var userToken = CacheHelper.getData("user");
    try {
      var response = await dio.get(
        "${Constants.baseUrl}/api/v1/wishlist",
        options: Options(
          headers: {"token": userToken},
        ),
      );
      GetWishlistModel model = GetWishlistModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(statusCode: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteWishlistModel>> deleteWishList(String productId) async{
    var userToken = CacheHelper.getData("user");
    try {
      var response = await dio.delete(
        "${Constants.baseUrl}/api/v1/wishlist/$productId",
        options: Options(
          headers: {"token": userToken},
        ),
      );
      DeleteWishlistModel model = DeleteWishlistModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(statusCode: e.toString()));
    }
  }
}

class HomeLocalDto implements HomeDataSource {
  @override
  Future<Either<Failure, CategoryOrBrandModel>> getBrands() {
    // TODO: implement getBrands
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CategoryOrBrandModel>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ProductModel>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, CartResponseModel>> addToCart(String productId) {
    // TODO: implement addCart
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AddWishlistModel>> addToWishList(String id) {
    // TODO: implement addToWishList
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, GetWishlistModel>> getWishList() {
    // TODO: implement getWishList
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, DeleteWishlistModel>> deleteWishList(String productId) {
    // TODO: implement deleteWishList
    throw UnimplementedError();
  }
}
