import 'package:e_commerce_app/Core/constants/constants.dart';
import 'package:e_commerce_app/Core/services/web_service.dart';
import 'package:e_commerce_app/Data/data_sources/signup/signup_datasource.dart';
import 'package:e_commerce_app/Data/models/signup/signup_request.dart';
import 'package:e_commerce_app/Data/repository_imp/signup/signUp_repositoryimp.dart';
import 'package:e_commerce_app/Domain/repositries/signup/signup_repository.dart';
import 'package:e_commerce_app/Domain/usecase/signup/signup_usecase.dart';
import 'package:e_commerce_app/Features/signup/manager/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitState());

  late SignUpDataSource signUpDataSource;
  late SignUpRepository signUpRepository;
  late SignUpUseCase signUpUseCase;
  final WebService webService = WebService(Constants.baseUrl);

  SignUpCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void signUp() async {

    emit(SignUpLoadingState());

    signUpDataSource = SignUpDataSource(webService.publicDio);
    signUpRepository = SignUpRepositoryImp(signUpDataSource);
    signUpUseCase = SignUpUseCase(signUpRepository);

    var result = await signUpUseCase.excute(
      SignUpRequestModel(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        rePassword: passwordController.text,
        phoneNumber: phoneController.text,
      ),
    );

    result.fold(
      (fail) {
        emit(SignUpErrorState(fail));
      },
      (data) {
        emit(SignUpSuccessState(data));
      },
    );
  }
}
