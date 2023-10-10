import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Domain/entity/home/category_entity.dart';
import 'package:e_commerce_app/Domain/entity/home/product_entity.dart';

abstract class HomeRepository{

  Future<Either<Failure, CategoryOrBrandEntity>> getCategories();

  Future<Either<Failure, CategoryOrBrandEntity>> getBrands();
  Future<Either<Failure, ProductEntity>> getProducts();
}