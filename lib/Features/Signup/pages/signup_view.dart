import 'package:e_commerce_app/Core/config/page_route_name.dart';
import 'package:e_commerce_app/Core/constants/constants.dart';
import 'package:e_commerce_app/Core/extentions/extentions.dart';
import 'package:e_commerce_app/Core/services/web_service.dart';
import 'package:e_commerce_app/Core/widgets/custom_textfield.dart';
import 'package:e_commerce_app/Data/data_sources/signup/signup_datasource.dart';
import 'package:e_commerce_app/Data/models/signup/signup_request.dart';
import 'package:e_commerce_app/Data/repository_imp/signup/signUp_repositoryimp.dart';
import 'package:e_commerce_app/Domain/repositries/signup/signup_repository.dart';
import 'package:e_commerce_app/Domain/usecase/signup/signup_usecase.dart';
import 'package:e_commerce_app/Features/signup/manager/cubit.dart';
import 'package:e_commerce_app/Features/signup/manager/states.dart';
import 'package:e_commerce_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Core/services/cache_helper.dart';

class SignUpView extends StatefulWidget {
  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final WebService webService = WebService(Constants.baseUrl);
  late SignUpDataSource signUpDataSource;
  late SignUpRepository signUpRepository;
  late SignUpUseCase signUpUseCase;

  @override
  void initState() {
    signUpDataSource = SignUpDataSource(webService.publicDio);
    signUpRepository = SignUpRepositoryImp(signUpDataSource);
    signUpUseCase = SignUpUseCase(signUpRepository);
    super.initState();
  }

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // signUpUseCase.excute(
    //   const SignUpRequestModel(
    //     name: "Bishoy Girgis",
    //     email: "bishoy@gmail.com",
    //     password: "123123123",
    //     rePassword: "123123123",
    //     phoneNumber: "01280835258",
    //   ),
    // );
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpLoadingState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            );
          } else if (state is SignUpErrorState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: Text("Error : ${state.failure.message}"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else if (state is SignUpSuccessState) {
            CacheHelper.saveData(key: "user", value: state.signUpEntity.token);
            CacheHelper.saveData(key: "username", value: state.signUpEntity.userName);
            CacheHelper.saveData(key: "usermail", value: state.signUpEntity.userEmail);
            navigatorKey.currentState?.pushNamedAndRemoveUntil(PageRouteName.home, (route) => false);
          }
        },
        builder: (context, state) {
          var theme = Theme.of(context);
          var mediaQuery = MediaQuery.of(context).size;
          var cubit = SignUpCubit().get(context);
          return Form(
            key: formKey,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      "assets/images/logos/route_logo.png",
                      scale: 1.2,
                    ),
                    Text(
                      "Full Name",
                      style: theme.textTheme.bodyMedium,
                    ),
                    CustomTextField(
                      onValidate: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "you must enter your Full Name";
                        } else {
                          return null;
                        }
                      },
                      hint: "enter your full name",
                      controller: cubit.nameController,
                    ).setOnlyVerticalPadding(context,
                        top: 0.008, bottom: 0.025),
                    Text(
                      "Mobile Number",
                      style: theme.textTheme.bodyMedium,
                    ),
                    CustomTextField(
                      onValidate: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "you must enter Mobile Number";
                        } else if (value.length < 10) {
                          return "description cant be less than 10 characters";
                        } else {
                          return null;
                        }
                      },
                      hint: "enter your mobile no.",
                      controller: cubit.phoneController,
                    ).setOnlyVerticalPadding(context,
                        top: 0.008, bottom: 0.025),
                    Text(
                      "E-mail address",
                      style: theme.textTheme.bodyMedium,
                    ),
                    CustomTextField(
                      onValidate: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "you must enter your e-mail";
                        } else {
                          return null;
                        }
                      },
                      hint: "enter your email address",
                      controller: cubit.emailController,
                    ).setOnlyVerticalPadding(context,
                        top: 0.008, bottom: 0.025),
                    Text(
                      "Password",
                      style: theme.textTheme.bodyMedium,
                    ),
                    CustomTextField(
                      onValidate: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "you must enter your password";
                        } else if (value.length < 6) {
                          return "description cant be less than 6 characters";
                        } else {
                          return null;
                        }
                      },
                      hint: "enter your password",
                      controller: cubit.passwordController,
                      isPassword: true,
                    ).setOnlyVerticalPadding(context,
                        top: 0.008, bottom: 0.125),
                    TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.signUp();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(theme.primaryColor),
                        padding:
                            const MaterialStatePropertyAll(EdgeInsets.all(14)),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      child: Text("Sign up", style: theme.textTheme.bodyLarge),
                    ),
                    TextButton(
                        onPressed: () {
                          navigatorKey.currentState
                              ?.pushReplacementNamed(PageRouteName.login);
                        },
                        child: Text(
                          "Already Have An Account ?",
                          style: theme.textTheme.bodySmall,
                        )).setOnlyVerticalPadding(context, top: 0.01)
                  ],
                )
                    .setOnlyVerticalPadding(context, top: 0.1)
                    .setHorizontalPadding(context, 0.04),
              ),
            ),
          );
        },
      ),
    );
  }
}
