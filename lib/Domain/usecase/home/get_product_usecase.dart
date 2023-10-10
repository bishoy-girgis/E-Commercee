import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Domain/repositries/home/home_repository.dart';
import '../../../Core/error/faliure.dart';
import '../../entity/home/product_entity.dart';

class GetProductUseCase {
  final HomeRepository homeRepository;

  GetProductUseCase(this.homeRepository);

  Future<Either<Failure, ProductEntity>> execute() =>
      homeRepository.getProducts();
}
