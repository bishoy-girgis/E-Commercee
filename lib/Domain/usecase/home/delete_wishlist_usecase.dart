import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Domain/entity/home/delete_wishlist_entity.dart';

import '../../repositries/home/home_repository.dart';

class DeleteWishListUseCase{
  HomeRepository homeRepository;
  DeleteWishListUseCase(this.homeRepository);
  Future<Either<Failure,DeleteWishlistEntity >> execute(String productId)=>homeRepository.deleteWishList(productId);
}