import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Domain/repositries/home/home_repository.dart';

import '../../../Core/error/faliure.dart';
import '../../entity/home/category_entity.dart';

class GetCategoriesUseCase {
  final HomeRepository getCategoriesRepository;

  GetCategoriesUseCase(this.getCategoriesRepository);

  Future<Either<Failure, List<CategoryEntity>>> excute() async {
    return await getCategoriesRepository.getCategories();
  }
}
