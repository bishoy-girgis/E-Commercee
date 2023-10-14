import 'package:e_commerce_app/Features/Forgot/manager/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Core/constants/constants.dart';
import '../../../Core/services/web_service.dart';
import '../../../Data/data_sources/login/login_datasource.dart';
import '../../../Data/repository_imp/login/login_repository_imp.dart';
import '../../../Domain/repositries/login/login_repository.dart';
import '../../../Domain/usecase/login/forgot_password-usecase.dart';

class ForgotCubit extends Cubit<ForgotStates> {
  ForgotCubit() : super(ForgotInitState());

  ForgotCubit get(context) => BlocProvider.of(context);
  final WebService webService = WebService(Constants.baseUrl);
  late LoginDataSource loginDataSource;
  late LoginRepository loginRepository;

  late ForgotPasswordUseCase forgotPasswordUseCase;

  TextEditingController userNameController = TextEditingController();

  void forgotPassword() async {
    emit(ForgotLoadingState());

    loginDataSource = LoginDataSource(webService.publicDio);
    loginRepository = LoginRepositoryImp(loginDataSource);
    forgotPasswordUseCase = ForgotPasswordUseCase(loginRepository);

    var result = await forgotPasswordUseCase.execute(
      userNameController.text,
    );

    result.fold(
      (fail) {
        emit(ForgotErrorState(fail));
      },
      (data) {
        emit(ForgotSuccessState(data));
      },
    );
  }
}
