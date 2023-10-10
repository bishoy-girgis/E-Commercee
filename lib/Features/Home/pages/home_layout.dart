import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_commerce_app/Core/extentions/extentions.dart';
import 'package:e_commerce_app/Core/widgets/custom_textfield.dart';
import 'package:e_commerce_app/Features/Home/manager/cubit.dart';
import 'package:e_commerce_app/Features/Home/manager/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homelayout extends StatelessWidget {
  const Homelayout({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocProvider(
      create: (context) => HomeCubit()..getCategories(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit().get(context);
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: false,
              title: Image.asset(
                "assets/images/logos/route_logo.png",
                height: 28,
              ),
            ),
            body: cubit.pages[cubit.currentIndex],
            bottomNavigationBar: CurvedNavigationBar(
              items: const [
                ImageIcon(AssetImage("assets/images/icons/home.png"),
                    size: 23, color: Colors.white),
                ImageIcon(AssetImage("assets/images/icons/category.png"),
                    size: 23, color: Colors.white),
                ImageIcon(AssetImage("assets/images/icons/favorite.png"),
                    size: 23, color: Colors.white),
                ImageIcon(AssetImage("assets/images/icons/profile.png"),
                    size: 23, color: Colors.white),
              ],
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 250),
              height: 50,
              buttonBackgroundColor: theme.primaryColor,
              backgroundColor: Colors.transparent,
              color: theme.primaryColor,
              onTap: (int index) {
                cubit.changeIndex(index);
              },
              index: cubit.currentIndex,
            ),
          );
        },
      ),
    );
  }
}
