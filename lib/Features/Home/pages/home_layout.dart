import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_commerce_app/Core/config/page_route_name.dart';
import 'package:e_commerce_app/Core/extentions/extentions.dart';
import 'package:e_commerce_app/Core/services/toast.dart';
import 'package:e_commerce_app/Data/data_sources/home/home_datasource.dart';
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
      create: (context) => HomeCubit(HomeRemoteDto())
        ..getCategories()
        ..getBrands()
        ..getProduct()
      ..getWishList(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is HomeLoadingState) {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                title: Center(
                  child: CircularProgressIndicator(),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            );
          } else if (state is AddToCartErrorState) {
            errorToast(context,description: state.failure.statusCode);
          }  else if (state is AddToCartSuccessState) {
            successToast(context,description: "Added To Cart Successfully",title: "Cart");
          } else if (state is AddToWishListSuccessState) {
            successToast(context,description: "Added To WishList Successfully",title: "Wishlist");
          }else if (state is DeleteWishListSuccessState) {
            successToast(context,description: "Removed From Your WishList",title: "Wishlist");
          }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            extendBody: true,
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Badge(
                    alignment: AlignmentDirectional.topCenter,
                    label: Text(cubit.numOfItemsInCart.toString()),
                    child: IconButton(
                      onPressed: () {
                        print(cubit.numOfItemsInCart.toString());
                        Navigator.pushNamed(context, PageRouteName.cart);
                      },
                      icon: Icon(
                        CupertinoIcons.cart,
                        color: theme.primaryColor,
                        size: 30,
                      ),
                    ),
                  ),
                )
              ],
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: false,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/images/logos/super.png",
                  height: 24,
                ),
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
