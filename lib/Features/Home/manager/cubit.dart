import 'package:e_commerce_app/Core/constants/constants.dart';
import 'package:e_commerce_app/Core/services/web_service.dart';
import 'package:e_commerce_app/Data/repository_imp/home/home_repository_imp.dart';
import 'package:e_commerce_app/Domain/entity/home/category_entity.dart';
import 'package:e_commerce_app/Domain/entity/home/get_wishlist_entity.dart';
import 'package:e_commerce_app/Domain/entity/home/product_entity.dart';
import 'package:e_commerce_app/Domain/repositries/home/home_repository.dart';
import 'package:e_commerce_app/Domain/usecase/cart/update_cart_usecase.dart';
import 'package:e_commerce_app/Domain/usecase/home/add_address_usecase.dart';
import 'package:e_commerce_app/Domain/usecase/home/add_cart_usecase.dart';
import 'package:e_commerce_app/Domain/usecase/home/add_wishlist_usecase.dart';
import 'package:e_commerce_app/Domain/usecase/home/delete_wishlist_usecase.dart';
import 'package:e_commerce_app/Domain/usecase/home/get_brands_usecase.dart';
import 'package:e_commerce_app/Domain/usecase/home/get_categories_usecase.dart';
import 'package:e_commerce_app/Domain/usecase/home/get_product_usecase.dart';
import 'package:e_commerce_app/Domain/usecase/home/update_user_usecase.dart';
import 'package:e_commerce_app/Features/Home/manager/states.dart';
import 'package:e_commerce_app/Features/Home/pages/categories_view.dart';
import 'package:e_commerce_app/Features/Home/pages/favourite_view.dart';
import 'package:e_commerce_app/Features/Home/pages/home_view.dart';
import 'package:e_commerce_app/Features/Home/pages/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Core/services/cache_helper.dart';
import '../../../Data/data_sources/home/home_datasource.dart';
import '../../../Domain/usecase/home/get_wishlist_usecase.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeDataSource homeDataSource;
  late HomeRepository homeRepository;

  HomeCubit(this.homeDataSource) : super(HomeInitState()) {
    homeRepository = HomeRepositoryImp(homeDataSource);
  }

  static HomeCubit get(context) => BlocProvider.of(context);
  TextEditingController nameController =  TextEditingController(text: "${CacheHelper.getData("username")}");
  TextEditingController emailController = TextEditingController(text: "${CacheHelper.getData("usermail")}",);
  TextEditingController phoneController = TextEditingController(text: "${CacheHelper.getData("userphone")}",);

  TextEditingController buildingNameController =  TextEditingController();
  TextEditingController buildingDetailsController =  TextEditingController();
  TextEditingController buildingCityController =  TextEditingController();
  bool editProfile = false;
  bool addAddress = false;

  int numOfItemsInCart = 0;
  List<Widget> pages = [
    const HomeView(),
    const CategoriesView(),
    const FavouriteView(),
    const ProfileView(),
  ];

  int currentIndex = 0;

  void changeIndex(int v) {
    emit(HomeInitState());
    currentIndex = v;
    emit(ChangeCurrentIndexState());
  }

  List<Widget> slidesImages = [
    Image.asset("assets/images/paintings/slide1.png"),
    Image.asset("assets/images/paintings/slide2.png"),
    Image.asset("assets/images/paintings/slide3.png"),
  ];

  List<DataEntity> categories = [];
  List<DataEntity> brands = [];
  List<ProductDataEntity> products = [];
  List<DataWishListEntity> wishListProduct = [];

  addToCart(String productId) async {
    emit(AddToCartLoadingState());
    AddCartUseCase addCartUseCase = AddCartUseCase(homeRepository);
    var result = await addCartUseCase.execute(productId);
    result.fold((l) {
      print(l.message);
      emit(AddToCartErrorState(l));
    }, (data) {
      numOfItemsInCart = data.numOfCartItems ?? 0;
      emit(AddToCartSuccessState(data));
    });
  }

  updateUser() async {
    emit(UpdateUserLoadingState());
    UpdateUserUseCase updateUserUseCase = UpdateUserUseCase(homeRepository);
    var result = await updateUserUseCase.execute(
      email: emailController.text,
      name: nameController.text,
      phone: phoneController.text,
    );
    result.fold((l) {
      print("erorrrrrrrrrr ${l.statusCode}");
      print("erorrrrrrrrrr ${l.message}");
      emit(UpdateUserErrorState(l));
    }, (data) {
      emit(UpdateUserSuccessState());
    });
  }

  addUserAddress() async {
    emit(AddAddressLoadingState());
    AddAddressUseCase addAddressUseCase = AddAddressUseCase(homeRepository);
    var result = await addAddressUseCase.execute(
      name: buildingNameController.text,
      details: buildingDetailsController.text,
      city: buildingCityController.text,
    );
    result.fold((l) {
      print("erorrrrrrrrrr ${l.statusCode}");
      print("erorrrrrrrrrr ${l.message}");
      emit(AddAddressErrorState(l));
    }, (data) {
      emit(AddAddressSuccessState());
    });
  }


  addToWishList(String productId) async {
    emit(AddToWishListLoadingState());
    AddWishListUseCase addWishListUseCase = AddWishListUseCase(homeRepository);
    var result = await addWishListUseCase.execute(productId);
    result.fold((l) {
      print(l.message);
      emit(AddToWishListErrorState(l));
    }, (data) {
      emit(AddToWishListSuccessState(data));
      getWishList();
    });
  }

  deleteWishList(String productId) async {
    emit(DeleteWishListLoadingState());
    DeleteWishListUseCase deleteWishListUseCase =
        DeleteWishListUseCase(homeRepository);
    var result = await deleteWishListUseCase.execute(productId);
    result.fold((l) {
      print(l.statusCode);
      emit(DeleteWishListErrorState(l));
    }, (data) {
      emit(DeleteWishListSuccessState(data));
      getWishList();
    });
  }

  getWishList() async {
    emit(GetWishListLoadingState());
    GetWishListUseCase getWishListUseCase = GetWishListUseCase(homeRepository);
    var result = await getWishListUseCase.execute();
    result.fold((l) {
      print(l.statusCode);
      emit(GetWishListErrorState(l));
    }, (data) {
      wishListProduct = data.data ?? [];
      emit(GetWishListSuccessState(data));
    });
  }

  getProduct() async {
    emit(HomeLoadingState());
    GetProductUseCase getProductUseCase = GetProductUseCase(homeRepository);
    var result = await getProductUseCase.execute();
    result.fold((l) {
      if (kDebugMode) {
        print(l.message);
      }
      emit(HomeGetProductErrorState(l));
    }, (data) {
      products = data.data ?? [];
      emit(HomeGetProductSuccessState(data));
    });
  }

  getBrands() async {
    emit(HomeLoadingState());
    GetBrandsUseCase getBrandsUseCase = GetBrandsUseCase(homeRepository);
    var result = await getBrandsUseCase.execute();
    result.fold((l) {
      print("${l.message}.......................................");
      emit(HomeGetBrandErrorState(l));
    }, (data) {
      brands = data.data ?? [];
      emit(HomeGetBrandSuccessState(data));
    });
  }

  getCategories() async {
    emit(HomeLoadingState());
    GetCategoriesUseCase getCategoriesUseCase =
        GetCategoriesUseCase(homeRepository);
    var result = await getCategoriesUseCase.execute();
    result.fold((fail) {
      print("${fail.message}.......................................");

      emit(HomeGetCategoryErrorState(fail));
    }, (data) {
      categories = data.data ?? [];
      emit(HomeGetCategorySuccessState(data));
    });
  }

  onEditProfile() {
    if (editProfile == true) {
      editProfile = false;
    } else {
      editProfile = true;
    }
    emit(ShowEditProfileState());
  }

  onAddAddress() {
    if (addAddress == true) {
      addAddress = false;
    } else {
      addAddress = true;
    }
    emit(ShowAddAddressState());
  }
}
