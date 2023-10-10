import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/Data/models/home/cart_response_model.dart';

import '../../../Core/constants/constants.dart';
import '../../../Core/error/faliure.dart';
import '../../../Core/services/cache_helper.dart';
import '../../models/cart/get_cart_model.dart';

abstract class CartDataSource {
  Future<Either<Failure, GetCartModel>> getCart();

  Future<Either<Failure, GetCartModel>> deleteItemFromCart(String id);

  Future<Either<Failure, GetCartModel>> updateItemFromCart(
      String id, int count);
}

class CartRemoteDto implements CartDataSource {
  Dio dio = Dio();
  var userToken = CacheHelper.getData("user");

  @override
  Future<Either<Failure, GetCartModel>> getCart() async {
    try {
      var response = await dio.get(
        "${Constants.baseUrl}/api/v1/cart",
        options: Options(
          headers: {"token": userToken},
        ),
      );
      GetCartModel model = GetCartModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(statusCode: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetCartModel>> deleteItemFromCart(String id) async {
    try {
      var response = await dio.delete(
        "${Constants.baseUrl}/api/v1/cart/$id",
        options: Options(
          headers: {"token": userToken},
        ),
      );
      GetCartModel model = GetCartModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(statusCode: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetCartModel>> updateItemFromCart(
      String id, int count) async {
    try {
      var response = await dio.put(
        "${Constants.baseUrl}/api/v1/cart/$id",
        options: Options(
          headers: {"token": userToken},
        ),
        data: {"count": count},
      );
      GetCartModel model = GetCartModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(statusCode: e.toString()));
    }
  }
}

class CartLocalDto implements CartDataSource {
  @override
  Future<Either<Failure, GetCartModel>> getCart() {
    // TODO: implement getCart
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, GetCartModel>> deleteItemFromCart(String id) {
    // TODO: implement deleteItemFromCart
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, GetCartModel>> updateItemFromCart(
      String id, int count) {
    // TODO: implement updateItemFromCart
    throw UnimplementedError();
  }
}
