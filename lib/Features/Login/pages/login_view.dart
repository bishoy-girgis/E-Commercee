import 'package:e_commerce_app/Core/extentions/extentions.dart';
import 'package:e_commerce_app/Features/Login/manager/cubit.dart';
import 'package:e_commerce_app/Features/Login/manager/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/config/page_route_name.dart';
import '../../../Core/constants/constants.dart';
import '../../../Core/services/web_service.dart';
import '../../../Core/widgets/custom_textfield.dart';
import '../../../Data/data_sources/login/login_datasource.dart';
import '../../../Data/repository_imp/login/login_repository_imp.dart';
import '../../../Domain/repositries/login/login_repository.dart';
import '../../../Domain/usecase/login/login_usecase.dart';
import '../../../main.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final WebService webService = WebService(Constants.baseUrl);
  late LoginDataSource loginDataSource;
  late LoginRepository loginRepository;
  late LoginUseCase loginUseCase;

  @override
  void initState() {
    loginDataSource = LoginDataSource(webService.publicDio);
    loginRepository = LoginRepositoryImp(loginDataSource);
    loginUseCase = LoginUseCase(loginRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
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
          } else if (state is LoginErrorState) {
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
          } else if (state is LoginSuccessState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: const Text("Login Successfully"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                     navigatorKey.currentState?.pushNamedAndRemoveUntil(PageRouteName.home, (route) => false);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          var theme = Theme.of(context);
          var mediaQuery = MediaQuery.of(context).size;
          var cubit = LoginCubit().get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    "assets/images/logos/route_logo.png",
                    scale: 1.2,
                  ),
                  Text("Welcome Back To Route ",
                          style: theme.textTheme.headlineMedium)
                      .setOnlyVerticalPadding(context, top: 0.02),
                  Text(
                    "Please sign in with your mail",
                    style: theme.textTheme.bodySmall,
                  ).setOnlyVerticalPadding(context, bottom: 0.03, top: 0.002),
                  Text(
                    "User name",
                    style: theme.textTheme.bodyMedium,
                  ),
                  CustomTextField(
                    hint: "enter your user name",
                    controller: cubit.userNameController,
                  ).setOnlyVerticalPadding(context, top: 0.01, bottom: 0.03),
                  Text(
                    "Password",
                    style: theme.textTheme.bodyMedium,
                  ),
                  CustomTextField(
                    hint: "enter your password",
                    controller: cubit.passwordController,
                    isPassword: true,
                  ).setOnlyVerticalPadding(context, top: 0.01),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot password",
                          style: theme.textTheme.bodySmall,
                        )).setOnlyVerticalPadding(context, bottom: 0.15),
                  ),
                  TextButton(
                    onPressed: () {
                      cubit.logIn();
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
                    child: Text("Login", style: theme.textTheme.bodyLarge),
                  ),
                  TextButton(
                      onPressed: () {
                        navigatorKey.currentState
                            ?.pushReplacementNamed(PageRouteName.signUp);
                      },
                      child: Text(
                        "Don’t have an account? Create Account",
                        style: theme.textTheme.bodySmall,
                      )).setOnlyVerticalPadding(context, top: 0.01)
                ],
              )
                  .setOnlyVerticalPadding(context, top: 0.1)
                  .setHorizontalPadding(context, 0.04),
            ),
          );
        },
      ),
    );
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: [
    //         Image.asset(
    //           "assets/images/logos/route_logo.png",
    //           scale: 1.2,
    //         ),
    //         Text("Welcome Back To Route ",
    //             style: theme.textTheme.headlineMedium).setOnlyVerticalPadding(context,top: 0.02 ),
    //         Text(
    //           "Please sign in with your mail",
    //           style: theme.textTheme.bodySmall,
    //         ).setOnlyVerticalPadding(context, bottom: 0.03, top: 0.002),
    //         Text(
    //           "User name",
    //           style: theme.textTheme.bodyMedium,
    //         ),
    //         const CustomTextField(
    //           hint: "enter your user name",
    //           //controller: cubit.nameController,
    //         ).setOnlyVerticalPadding(context, top: 0.01, bottom: 0.03),
    //         Text(
    //           "Password",
    //           style: theme.textTheme.bodyMedium,
    //         ),
    //         const CustomTextField(
    //           hint: "enter your password",
    //           //controller: cubit.passwordController,
    //           isPassword: true,
    //         ).setOnlyVerticalPadding(context, top: 0.01),
    //         Align(
    //           alignment: Alignment.centerRight,
    //           child: TextButton(
    //               onPressed: () {},
    //               child: Text(
    //                 "Forgot password",
    //                 style: theme.textTheme.bodySmall,
    //               )).setOnlyVerticalPadding(context, bottom: 0.15),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             //cubit.signUp();
    //           },
    //           style: ButtonStyle(
    //             backgroundColor: MaterialStatePropertyAll(theme.primaryColor),
    //             padding: const MaterialStatePropertyAll(EdgeInsets.all(14)),
    //             shape: MaterialStatePropertyAll(
    //               RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(25),
    //               ),
    //             ),
    //           ),
    //           child: Text("Login", style: theme.textTheme.bodyLarge),
    //         ),
    //         TextButton(
    //             onPressed: () {
    //               navigatorKey.currentState
    //                   ?.pushReplacementNamed(PageRouteName.signUp);
    //             },
    //             child: Text(
    //               "Don’t have an account? Create Account",
    //               style: theme.textTheme.bodySmall,
    //             )).setOnlyVerticalPadding(context,top: 0.01)
    //       ],
    //     )
    //         .setOnlyVerticalPadding(context, top: 0.1)
    //         .setHorizontalPadding(context, 0.04),
    //   ),
    // );
  }
}
