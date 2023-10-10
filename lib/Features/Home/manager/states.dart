import 'package:e_commerce_app/Data/models/home/cart_response_model.dart';
import 'package:e_commerce_app/Domain/entity/home/add_wishlist_entity.dart';
import 'package:e_commerce_app/Domain/entity/home/category_entity.dart';
import 'package:e_commerce_app/Domain/entity/home/delete_wishlist_entity.dart';
import 'package:e_commerce_app/Domain/entity/home/get_wishlist_entity.dart';
import 'package:e_commerce_app/Domain/entity/home/product_entity.dart';

import '../../../Core/error/faliure.dart';

abstract class HomeStates {}

class HomeInitState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeGetBrandSuccessState extends HomeStates {
  CategoryOrBrandEntity model;

  HomeGetBrandSuccessState(this.model);
}

class HomeGetCategorySuccessState extends HomeStates {
  CategoryOrBrandEntity model;

  HomeGetCategorySuccessState(this.model);
}

class HomeGetProductSuccessState extends HomeStates {
  ProductEntity model;

  HomeGetProductSuccessState(this.model);
}

class HomeGetBrandErrorState extends HomeStates {
  Failure failure;

  HomeGetBrandErrorState(this.failure);
}

class HomeGetProductErrorState extends HomeStates {
  Failure failure;

  HomeGetProductErrorState(this.failure);
}

class HomeGetCategoryErrorState extends HomeStates {
  Failure failure;

  HomeGetCategoryErrorState(this.failure);
}

class ChangeCurrentIndexState extends HomeStates {}

class AddToCartLoadingState extends HomeStates {}

class AddToCartErrorState extends HomeStates {
  Failure failure;

  AddToCartErrorState(this.failure);
}

class AddToCartSuccessState extends HomeStates {
  CartResponseModel model;

  AddToCartSuccessState(this.model);
}


class AddToWishListLoadingState extends HomeStates {}
class AddToWishListErrorState extends HomeStates {
  Failure failure;

  AddToWishListErrorState(this.failure);
}

class AddToWishListSuccessState extends HomeStates {
  AddWishlistEntity model;

  AddToWishListSuccessState(this.model);
}


class GetWishListLoadingState extends HomeStates {}
class GetWishListErrorState extends HomeStates {
  Failure failure;

  GetWishListErrorState(this.failure);
}

class GetWishListSuccessState extends HomeStates {
  GetWishlistEntity model;

  GetWishListSuccessState(this.model);
}



class DeleteWishListLoadingState extends HomeStates {}
class DeleteWishListErrorState extends HomeStates {
  Failure failure;

  DeleteWishListErrorState(this.failure);
}

class DeleteWishListSuccessState extends HomeStates {
  DeleteWishlistEntity model;

  DeleteWishListSuccessState(this.model);
}
