import 'package:e_commerce_app/Core/config/page_route_name.dart';
import 'package:e_commerce_app/Data/models/cart/get_cart_model.dart';
import 'package:e_commerce_app/Domain/entity/home/product_entity.dart';
import 'package:e_commerce_app/Features/Home/pages/home_layout.dart';
import 'package:e_commerce_app/Features/Forgot/pages/forgot_password_view.dart';
import 'package:e_commerce_app/Features/Login/pages/login_view.dart';
import 'package:e_commerce_app/Features/Login/pages/verify_account.dart';
import 'package:e_commerce_app/Features/Payment/pages/payment_view.dart';
import 'package:e_commerce_app/Features/Payment/pages/webview.dart';
import 'package:e_commerce_app/Features/Product_Details/pages/product_details_view.dart';
import 'package:e_commerce_app/Features/Splash/splash_view.dart';
import 'package:e_commerce_app/Features/signup/pages/signup_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Features/Cart/pages/cart_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case PageRouteName.initial:
        return MaterialPageRoute<dynamic>(
            builder: (context) => const SplashView(), settings: routeSettings);
      case PageRouteName.login:
        return MaterialPageRoute(
            builder: (context) => const LoginView(), settings: routeSettings);
      case PageRouteName.forgotPassword:
        return MaterialPageRoute(
            builder: (context) => ForgotPasswordView(), settings: routeSettings);
      case PageRouteName.signUp:
        return MaterialPageRoute(
            builder: (context) => SignUpView(), settings: routeSettings);
      case PageRouteName.home:
        return MaterialPageRoute(
            builder: (context) => const Homelayout(), settings: routeSettings);
      case PageRouteName.productDetails:
        ProductDataEntity product = routeSettings.arguments as ProductDataEntity;
        return MaterialPageRoute(
            builder: (context) => ProductDetailsView(product),
            settings: routeSettings);
      case PageRouteName.cart:
        return MaterialPageRoute(
            builder: (context) => const CartView(), settings: routeSettings);
      case PageRouteName.verify:
        return MaterialPageRoute(
            builder: (context) => const VerifyAccount(), settings: routeSettings);
      case PageRouteName.payment:
        GetCartModel getCartModel = routeSettings.arguments as GetCartModel;
        return MaterialPageRoute(
            builder: (context) =>  PaymentView(getCartModel), settings: routeSettings);
      case PageRouteName.webView:
        return MaterialPageRoute(
            builder: (context) =>  WebView(), settings: routeSettings);
      default:
        return MaterialPageRoute<dynamic>(
            builder: (context) => const SplashView(), settings: routeSettings);
    }
  }
}
