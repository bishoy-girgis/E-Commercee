import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/Core/constants/constants.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Data/models/home/category_or_brand_model.dart';
import 'package:e_commerce_app/Data/models/home/product_model.dart';
import 'package:e_commerce_app/Domain/entity/home/product_entity.dart';

abstract class HomeDataSource {
  Future<Either<Failure, CategoryOrBrandModel>> getBrands();

  Future<Either<Failure, CategoryOrBrandModel>> getCategories();

  Future<Either<Failure, ProductModel>> getProducts();
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


}
