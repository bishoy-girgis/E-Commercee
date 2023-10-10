import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Domain/entity/home/add_wishlist_entity.dart';
import 'package:e_commerce_app/Domain/repositries/home/home_repository.dart';

class AddWishListUseCase{

  HomeRepository homeRepository;
  AddWishListUseCase(this.homeRepository);
  Future<Either<Failure,AddWishlistEntity >> execute(String id) =>homeRepository.addToWishList(id);
}