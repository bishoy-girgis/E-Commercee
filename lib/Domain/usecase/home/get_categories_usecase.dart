import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Domain/repositries/home/home_repository.dart';

import '../../../Core/error/faliure.dart';
import '../../entity/home/category_entity.dart';

class GetCategoriesUseCase {
  final HomeRepository homeRepository;

  GetCategoriesUseCase(this.homeRepository);

  Future<Either<Failure, CategoryOrBrandEntity>> execute() async {
    return await homeRepository.getCategories();
  }
}
