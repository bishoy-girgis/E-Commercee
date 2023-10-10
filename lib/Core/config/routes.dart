import 'package:e_commerce_app/Core/config/page_route_name.dart';
import 'package:e_commerce_app/Features/Home/pages/home_layout.dart';
import 'package:e_commerce_app/Features/Login/pages/login_view.dart';
import 'package:e_commerce_app/Features/Splash/splash_view.dart';
import 'package:e_commerce_app/Features/signup/pages/signup_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case PageRouteName.initial:
        return MaterialPageRoute<dynamic>(
            builder: (context) => const SplashView(), settings: routeSettings);
      case PageRouteName.login:
        return MaterialPageRoute(
            builder: (context) => const LoginView(), settings: routeSettings);
      case PageRouteName.signUp:
        return MaterialPageRoute(
            builder: (context) => SignUpView(), settings: routeSettings);
      case PageRouteName.home:
        return MaterialPageRoute(
            builder: (context) => const Homelayout(), settings: routeSettings);
      default:
        return MaterialPageRoute<dynamic>(
            builder: (context) => const SplashView(), settings: routeSettings);
    }
  }
}
