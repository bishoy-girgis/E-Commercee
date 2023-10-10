import 'dart:async';

import 'package:e_commerce_app/Core/config/page_route_name.dart';
import 'package:e_commerce_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      navigatorKey.currentState?.pushReplacementNamed(PageRouteName.home);
    });
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Image.asset("assets/images/paintings/splash_screen.png",
          fit: BoxFit.cover,
          width: mediaQuery.width,
          height: mediaQuery.height),
    );
  }
}
