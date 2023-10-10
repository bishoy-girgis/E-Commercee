import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Domain/repositries/home/home_repository.dart';

import '../../entity/home/get_wishlist_entity.dart';

class GetWishListUseCase{
  HomeRepository homeRepository;
  GetWishListUseCase(this.homeRepository);

  Future<Either<Failure , GetWishlistEntity >>execute()=>homeRepository.getWishList();
}