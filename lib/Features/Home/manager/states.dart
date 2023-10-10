import 'package:e_commerce_app/Domain/entity/home/category_entity.dart';

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

class HomeGetBrandErrorState extends HomeStates {
  Failure failure;

  HomeGetBrandErrorState(this.failure);
}

class HomeGetCategoryErrorState extends HomeStates {
  Failure failure;

  HomeGetCategoryErrorState(this.failure);
}
class ChangeCurrentIndexState extends HomeStates {}

//
//
// class HomeSuccessState extends HomeStates {}
//
// class HomeErrorState extends HomeStates {
//   Failure failure;
//
//   HomeErrorState(this.failure);
// }
//class ChangeCurrentIndexState extends HomeStates {}
//
// class GetCategoryLoadingState extends HomeStates {}
//
// class GetCategorySuccessState extends HomeStates {
//   final List<CategoryOrBrandEntity> categoriesList;
//
//   GetCategorySuccessState(this.categoriesList);
// }
//
// class GetCategoryErrorState extends HomeStates {
//   Failure failure;
//
//   GetCategoryErrorState(this.failure);
// }
