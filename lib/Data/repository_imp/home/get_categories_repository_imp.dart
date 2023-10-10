import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Data/data_sources/home/get_categories_datasource.dart';
import 'package:e_commerce_app/Data/models/home/category_model.dart';
import 'package:e_commerce_app/Domain/entity/home/category_entity.dart';
import 'package:e_commerce_app/Domain/repositries/home/home_repository.dart';

class GetCategoriesRepositoryImp implements HomeRepository {
  final GetCategoriesDataSource dataSource;

  GetCategoriesRepositoryImp(this.dataSource);

  List<CategoryModel> categoriesList = [];

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      var result = await dataSource.getCategories();
      if (result.statusCode == 200) {
        for (var element in (result.data["data"] as Iterable)) {
          categoriesList.add(CategoryModel.fromJson(element));
        }
        return Right(categoriesList);
      } else {
        return left(ServerFailure(statusCode: result.statusCode.toString()));
      }
    } catch (e) {
      DioException error = e as DioException;
      return left(
          ServerFailure(statusCode: error.response!.statusCode.toString()));
    }
  }
}
