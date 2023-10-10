import 'package:e_commerce_app/Core/constants/constants.dart';
import 'package:e_commerce_app/Core/services/web_service.dart';
import 'package:e_commerce_app/Data/data_sources/home/get_categories_datasource.dart';
import 'package:e_commerce_app/Data/repository_imp/home/get_categories_repository_imp.dart';
import 'package:e_commerce_app/Domain/entity/home/category_entity.dart';
import 'package:e_commerce_app/Domain/repositries/home/home_repository.dart';
import 'package:e_commerce_app/Domain/usecase/home/get_categories_usecase.dart';
import 'package:e_commerce_app/Features/Home/manager/states.dart';
import 'package:e_commerce_app/Features/Home/pages/categories_view.dart';
import 'package:e_commerce_app/Features/Home/pages/favourite_view.dart';
import 'package:e_commerce_app/Features/Home/pages/home_view.dart';
import 'package:e_commerce_app/Features/Home/pages/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  HomeCubit get(context) => BlocProvider.of(context);

  final WebService webService = WebService(Constants.baseUrl);
  late GetCategoriesDataSource dataSource;
  late HomeRepository getCategoriesRepository;
  late GetCategoriesUseCase getCategoriesUseCase;

  List<CategoryEntity> categoriesList=[];

  List<Widget> pages = [
    const HomeView(),
    const CategoriesView(),
    const FavouriteView(),
    const ProfileView(),
  ];

  int currentIndex = 0;

  void changeIndex(int v) {
    currentIndex = v;
    emit(ChangeCurrentIndexState());
  }

  List<Widget> slidesImages = [
    Image.asset("assets/images/paintings/slide1.png"),
    Image.asset("assets/images/paintings/slide2.png"),
    Image.asset("assets/images/paintings/slide3.png"),
  ];

  getCategories() async {
    emit(GetCategoryLoadingState());
    dataSource = GetCategoriesDataSource(webService.publicDio);
    getCategoriesRepository = GetCategoriesRepositoryImp(dataSource);
    getCategoriesUseCase = GetCategoriesUseCase(getCategoriesRepository);

    var result = await getCategoriesUseCase.excute();

    result.fold((fail) {
      close();
      emit(GetCategoryErrorState(fail));
    }, (data) {
      categoriesList = data;
      emit(GetCategorySuccessState(data));
    });
  }
}
