import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Data/data_sources/home/home_datasource.dart';
import 'package:e_commerce_app/Domain/entity/home/category_entity.dart';
import 'package:e_commerce_app/Domain/entity/home/product_entity.dart';
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
}
