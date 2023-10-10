import 'package:e_commerce_app/Data/models/home/cart_response_model.dart';

import '../../../Core/error/faliure.dart';
import '../../../Data/models/cart/get_cart_model.dart';

abstract class CartStates {}

class CartInitState extends CartStates {}

class CartLoadingState extends CartStates {}

class CartErrorState extends CartStates {
  Failure failure;

  CartErrorState(this.failure);
}

class CartSuccessState extends CartStates {
  GetCartModel getCartModel;

  CartSuccessState(this.getCartModel);
}

class DeleteItemCartErrorState extends CartStates {
  Failure failure;

  DeleteItemCartErrorState(this.failure);
}

class DeleteItemCartSuccessState extends CartStates {
  GetCartModel getCartModel;

  DeleteItemCartSuccessState(this.getCartModel);
}
class UpdateItemCartErrorState extends CartStates {
  Failure failure;

  UpdateItemCartErrorState(this.failure);
}

class UpdateItemCartSuccessState extends CartStates {
  GetCartModel getCartModel;

  UpdateItemCartSuccessState(this.getCartModel);
}
