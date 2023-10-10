import 'package:e_commerce_app/Core/constants/constants.dart';
import 'package:e_commerce_app/Core/services/web_service.dart';
import 'package:e_commerce_app/Data/repository_imp/home/home_repository_imp.dart';
import 'package:e_commerce_app/Domain/entity/home/category_entity.dart';
import 'package:e_commerce_app/Domain/entity/home/product_entity.dart';
import 'package:e_commerce_app/Domain/repositries/home/home_repository.dart';
import 'package:e_commerce_app/Domain/usecase/home/get_brands_usecase.dart';
import 'package:e_commerce_app/Domain/usecase/home/get_categories_usecase.dart';
import 'package:e_commerce_app/Domain/usecase/home/get_product_usecase.dart';
import 'package:e_commerce_app/Features/Home/manager/states.dart';
import 'package:e_commerce_app/Features/Home/pages/categories_view.dart';
import 'package:e_commerce_app/Features/Home/pages/favourite_view.dart';
import 'package:e_commerce_app/Features/Home/pages/home_view.dart';
import 'package:e_commerce_app/Features/Home/pages/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Data/data_sources/home/home_datasource.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeDataSource homeDataSource;
  late HomeRepository homeRepository;

  HomeCubit(this.homeDataSource) : super(HomeInitState()) {
    homeRepository = HomeRepositoryImp(homeDataSource);
  }

  static HomeCubit get(context) => BlocProvider.of(context);

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

//
// List<CategoryOrBrandEntity> categoriesList = [];
// getCategories() async {
//   emit(GetCategoryLoadingState());
//   dataSource = HomeDataSource(webService.publicDio);
//   getCategoriesRepository = HomeRepositoryImp(dataSource);
//   getCategoriesUseCase = GetCategoriesUseCase(getCategoriesRepository);
//
//   var result = await getCategoriesUseCase.execute();
//
//   result.fold((fail) {
//     close();
//     emit(GetCategoryErrorState(fail));
//   }, (data) {
//     categoriesList = data;
//     emit(GetCategorySuccessState(data));
//   });
// }
}
