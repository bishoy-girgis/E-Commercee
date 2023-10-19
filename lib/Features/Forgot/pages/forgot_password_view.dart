import 'package:e_commerce_app/Core/extentions/extentions.dart';
import 'package:e_commerce_app/Core/services/toast.dart';
import 'package:e_commerce_app/Domain/usecase/login/forgot_password-usecase.dart';
import 'package:e_commerce_app/Features/Forgot/manager/cubit.dart';
import 'package:e_commerce_app/Features/Forgot/manager/states.dart';
import 'package:e_commerce_app/Features/Login/manager/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Core/config/page_route_name.dart';
import '../../../Core/constants/constants.dart';
import '../../../Core/services/web_service.dart';
import '../../../Core/widgets/custom_textfield.dart';
import '../../../Data/data_sources/login/login_datasource.dart';
import '../../../Data/repository_imp/login/login_repository_imp.dart';
import '../../../Domain/repositries/login/login_repository.dart';
import '../../../main.dart';

class ForgotPasswordView extends StatefulWidget {
  ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final WebService webService = WebService(Constants.baseUrl);
  late LoginDataSource loginDataSource;
  late LoginRepository loginRepository;
  late ForgotPasswordUseCase forgotPasswordUseCase;

  @override
  void initState() {
    loginDataSource = LoginDataSource(webService.publicDio);
    loginRepository = LoginRepositoryImp(loginDataSource);
    forgotPasswordUseCase = ForgotPasswordUseCase(loginRepository);
    super.initState();
  }

  //var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocProvider(
        create: (context) => ForgotCubit(),
        child: BlocConsumer<ForgotCubit, ForgotStates>(
          listener: (context, state) {
            if (state is ForgotLoadingState) {
              EasyLoading.show();
            } else if (state is ForgotErrorState) {
              EasyLoading.dismiss();
              errorToast(context,title: "Error",description: "Try Again Later");
            } else if (state is ForgotSuccessState) {
              EasyLoading.dismiss();
              successToast(context,title: "Success",description: (state.forgotPasswordEntity.message));
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Forgot Password",
                            style: theme.textTheme.headlineMedium)
                        .setOnlyVerticalPadding(context, top: 0.02),
                    Image.asset(
                      "assets/images/icons/forgot.png",
                      scale: 1.3,
                    ).setHorizontalPadding(context, 0.06),
                    Text(
                      textAlign: TextAlign.center,
                      "Enter your registered email below to receive \n password reset instruction",
                      style: theme.textTheme.bodySmall,
                    ).setOnlyVerticalPadding(context, bottom: 0.03, top: 0.002),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Email Address",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    CustomTextField(
                      onValidate: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "you must enter your e-mail";
                        } else {
                          return null;
                        }
                      },
                      hint: "enter your e-mail",
                      controller: ForgotCubit().get(context).userNameController,
                    ).setOnlyVerticalPadding(context, top: 0.01, bottom: 0.03),
                    SizedBox(
                      height: 50.h,
                    ),
                    TextButton(
                      onPressed: () {
                        // if (formKey.currentState!.validate()) {
                           ForgotCubit().get(context).forgotPassword();
                        // }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(theme.primaryColor),
                        padding:
                            const MaterialStatePropertyAll(EdgeInsets.all(18)),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                      child: Text("Send Verification Code",
                          style: theme.textTheme.bodyLarge),
                    ),
                    TextButton(
                        onPressed: () {
                          navigatorKey.currentState
                              ?.pushReplacementNamed(PageRouteName.login);
                        },
                        child: Text(
                          "Sign in to your Account ?",
                          style: theme.textTheme.bodySmall,
                        )).setOnlyVerticalPadding(context, top: 0.01)
                  ],
                )
                    .setOnlyVerticalPadding(context, top: 0.1)
                    .setHorizontalPadding(context, 0.04),
              ),
            );
          },
        ));
  }
}
