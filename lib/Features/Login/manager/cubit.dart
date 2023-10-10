import 'package:e_commerce_app/Core/constants/constants.dart';
import 'package:e_commerce_app/Core/services/web_service.dart';
import 'package:e_commerce_app/Data/data_sources/login/login_datasource.dart';
import 'package:e_commerce_app/Data/repository_imp/login/login_repository_imp.dart';
import 'package:e_commerce_app/Domain/repositries/login/login_repository.dart';
import 'package:e_commerce_app/Domain/usecase/login/login_usecase.dart';
import 'package:e_commerce_app/Features/Login/manager/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());

  final WebService webService = WebService(Constants.baseUrl);
  late LoginDataSource loginDataSource;
  late LoginRepository loginRepository;
  late LoginUseCase loginUseCase;

  LoginCubit get(context) => BlocProvider.of(context);

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void logIn() async {
    emit(LoginLoadingState());

    loginDataSource = LoginDataSource(webService.publicDio);
    loginRepository = LoginRepositoryImp(loginDataSource);
    loginUseCase = LoginUseCase(loginRepository);

    var result = await loginUseCase.excute(
      userNameController.text,
      passwordController.text,
    );

    result.fold(
      (fail) {
        emit(LoginErrorState(fail));
      },
      (user) {
        emit(LoginSuccessState());
      },
    );
  }
}
