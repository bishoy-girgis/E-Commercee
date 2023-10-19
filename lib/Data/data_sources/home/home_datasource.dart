import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/Core/constants/constants.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Data/models/home/add_wishlist_model.dart';
import 'package:e_commerce_app/Data/models/home/category_or_brand_model.dart';
import 'package:e_commerce_app/Data/models/home/delete_wishlist_model.dart';
import 'package:e_commerce_app/Data/models/home/get_wishlist_model.dart';
import 'package:e_commerce_app/Data/models/home/product_model.dart';
import 'package:e_commerce_app/Data/models/home/update_user_model.dart';
import 'package:e_commerce_app/Domain/entity/home/product_entity.dart';

import '../../../Core/services/cache_helper.dart';
import '../../models/home/add_address_model.dart';
import '../../models/home/cart_response_model.dart';

abstract class HomeDataSource {
  Future<Either<Failure, CategoryOrBrandModel>> getBrands();

  Future<Either<Failure, CategoryOrBrandModel>> getCategories();

  Future<Either<Failure, ProductModel>> getProducts();

  Future<Either<Failure, CartResponseModel>> addToCart(String productId);

  Future<Either<Failure, AddWishlistModel>> addToWishList(String id);

  Future<Either<Failure, GetWishlistModel>> getWishList();

  Future<Either<Failure, DeleteWishlistModel>> deleteWishList(String productId);

  Future<Either<Failure, UpdateUserModel>> updateUser(
      String name, String email, String phone);

  Future<Either<Failure, AddAddressModel>> addAddress(
      String name, String details, String city);
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
  Future<Either<Failure, GetWishlistModel>> getWishList() async {
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
  Future<Either<Failure, DeleteWishlistModel>> deleteWishList(
      String productId) async {
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

  @override
  Future<Either<Failure, UpdateUserModel>> updateUser(
      String name, String email, String phone) async {
    var userToken = CacheHelper.getData("user");
    try {
      var response = await dio.put("${Constants.baseUrl}/api/v1/users/updateMe",
          options: Options(
            headers: {"token": userToken},
          ),
          data: {
            "name": name,
            "email": email,
            "phone": phone,
          });
      UpdateUserModel model = UpdateUserModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      DioException error = e as DioException;

      if (error.response?.statusCode == 401) {
        return left(
          ServerFailure(
            statusCode: error.response?.statusCode.toString() ?? "",
            message: error.response?.data["message"],
          ),
        );
      } else {
        return left(ServerFailure(
          statusCode: error.response?.statusCode.toString() ?? "",
          message: error.response?.data["errors"]["msg"],
        ));
      }
    }
  }

  @override
  Future<Either<Failure, AddAddressModel>> addAddress(
      String name, String details, String city) async {
    var userToken = CacheHelper.getData("user");
    try {
      var response = await dio.post("${Constants.baseUrl}/api/v1/addresses",
          options: Options(
            headers: {"token": userToken},
          ),
          data: {
            "name": name,
            "details": details,
            //"phone": "01280835258",
            "city": city
          });
      AddAddressModel model = AddAddressModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      DioException error = e as DioException;

      if (error.response?.statusCode == 401) {
        return left(
          ServerFailure(
            statusCode: error.response?.statusCode.toString() ?? "",
            message: error.response?.data["message"],
          ),
        );
      } else {
        return left(ServerFailure(
          statusCode: error.response?.statusCode.toString() ?? "",
          message: error.response?.data["errors"]["msg"],
        ));
      }
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
  Future<Either<Failure, DeleteWishlistModel>> deleteWishList(
      String productId) {
    // TODO: implement deleteWishList
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UpdateUserModel>> updateUser(
      String name, String email, String phone) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AddAddressModel>> addAddress(
      String name, String details, String city) {
    // TODO: implement addAddress
    throw UnimplementedError();
  }
}
