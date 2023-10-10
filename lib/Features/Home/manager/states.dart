import '../../../Core/error/faliure.dart';
import '../../../Domain/entity/home/category_entity.dart';

abstract class HomeStates {}

class HomeInitState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {}

class HomeErrorState extends HomeStates {
  Failure failure;

  HomeErrorState(this.failure);
}

class ChangeCurrentIndexState extends HomeStates {}

class GetCategoryLoadingState extends HomeStates {}

class GetCategorySuccessState extends HomeStates {
  final List<CategoryEntity> categoriesList;

  GetCategorySuccessState(this.categoriesList);
}

class GetCategoryErrorState extends HomeStates {
  Failure failure;

  GetCategoryErrorState(this.failure);
}
