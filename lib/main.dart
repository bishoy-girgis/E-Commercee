import 'package:e_commerce_app/Core/config/my_theme.dart';
import 'package:e_commerce_app/Core/config/page_route_name.dart';
import 'package:e_commerce_app/Core/config/routes.dart';
import 'package:e_commerce_app/Core/services/loading_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Core/services/bloc_observer.dart';
import 'Core/services/cache_helper.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  Bloc.observer = MyBlocObserver();
  configLoading();
  var user = CacheHelper.getData("user");
  String route;
  if (user == null) {
    route = PageRouteName.initial;
  } else {
    route = PageRouteName.home;
  }
  runApp(MyApp(route));
}

class MyApp extends StatelessWidget {
  String route;

  MyApp(this.route, {super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          builder: EasyLoading.init(),
          title: 'Flutter Demo',
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          initialRoute: route,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}