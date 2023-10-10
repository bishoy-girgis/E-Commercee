import 'package:e_commerce_app/Core/config/my_theme.dart';
import 'package:e_commerce_app/Core/config/page_route_name.dart';
import 'package:e_commerce_app/Core/config/routes.dart';
import 'package:e_commerce_app/Core/services/loading_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Core/services/bloc_observer.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
  Bloc.observer = MyBlocObserver();
  configLoading();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      debugShowCheckedModeBanner: false ,
      navigatorKey: navigatorKey,
      initialRoute: PageRouteName.initial,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
