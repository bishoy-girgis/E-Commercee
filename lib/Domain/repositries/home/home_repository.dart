import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Domain/entity/home/category_entity.dart';

abstract class HomeRepository{

  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}