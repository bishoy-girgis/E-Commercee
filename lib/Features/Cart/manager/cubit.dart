import 'package:e_commerce_app/Data/repository_imp/cart/cart_repository_imp.dart';
import 'package:e_commerce_app/Domain/repositries/cart/cart_repositorty.dart';
import 'package:e_commerce_app/Domain/usecase/cart/clear_cart_usecase.dart';
import 'package:e_commerce_app/Domain/usecase/cart/delete_item_from_cart_usecase.dart';
import 'package:e_commerce_app/Domain/usecase/cart/get_cart_usecase.dart';
import 'package:e_commerce_app/Domain/usecase/cart/update_cart_usecase.dart';
import 'package:e_commerce_app/Features/Cart/manager/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Core/constants/constants.dart';
import '../../../Core/services/web_service.dart';
import '../../../Data/data_sources/cart/cart_data_source.dart';

class CartCubit extends Cubit<CartStates> {
  CartDataSource cartDataSource;

  CartCubit(this.cartDataSource) : super(CartInitState());
  final WebService webService = WebService(Constants.baseUrl);

  static CartCubit get(context) => BlocProvider.of(context);

  getCart() async {
    CartRepository cartRepository = CartRepositoryImp(cartDataSource);
    GetCartUseCase cartUseCase = GetCartUseCase(cartRepository);
    var result = await cartUseCase.execute();

    result.fold((l) {
      emit(CartErrorState(l));
    }, (r) {
      emit(CartSuccessState(r));
    });
  }

  deleteItemFromCart(String id) async {
    CartRepository cartRepository = CartRepositoryImp(cartDataSource);
    DeleteItemFromCartUseCase deleteItemFromCartUseCase =
        DeleteItemFromCartUseCase(cartRepository);

    var result = await deleteItemFromCartUseCase.execute(id);
    result.fold((l) {
      emit(DeleteItemCartErrorState(l));
    }, (r) {
      emit(CartSuccessState(r));
    });
  }

  updateItemFromCart({required String id,required int count}) async {
    CartRepository cartRepository = CartRepositoryImp(cartDataSource);
    UpdateCartUseCase updateCartUseCase = UpdateCartUseCase(cartRepository);
    var result = await updateCartUseCase.execute(id, count);
    result.fold((l) {
      emit(UpdateItemCartErrorState(l));
    }, (r) {
      emit(CartSuccessState(r));
    });
  }

  clearCart() async {
    emit(ClearCartLoadingState());
    CartRepository cartRepository = CartRepositoryImp(cartDataSource);
    ClearCartUseCase clearCartUseCase = ClearCartUseCase(cartRepository);
    var result = await clearCartUseCase.execute();

    result.fold((l) {
      emit(ClearCartErrorState(l));
    }, (r) {
      emit(ClearCartSuccessState());
    });
  }
}
