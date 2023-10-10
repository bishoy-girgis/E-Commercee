import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Domain/entity/home/category_entity.dart';
import 'package:e_commerce_app/Domain/repositries/home/home_repository.dart';

class GetBrandsUseCase{
  HomeRepository homeRepository;
  GetBrandsUseCase(this.homeRepository);

  Future<Either<Failure,CategoryOrBrandEntity>> execute()=>homeRepository.getBrands();
}