import 'package:e_commerce_app/Core/config/page_route_name.dart';
import 'package:e_commerce_app/Core/extentions/extentions.dart';
import 'package:e_commerce_app/Core/services/toast.dart';
import 'package:e_commerce_app/Data/data_sources/cart/cart_data_source.dart';
import 'package:e_commerce_app/Features/Cart/manager/cubit.dart';
import 'package:e_commerce_app/Features/Cart/manager/states.dart';
import 'package:e_commerce_app/Features/Cart/widgets/cart_item.dart';
import 'package:e_commerce_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => CartCubit(CartRemoteDto())..getCart(),
      child: BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {
          if (state is CartLoadingState) {
            EasyLoading.show();
          } else if (state is CartErrorState) {
            EasyLoading.dismiss();
            errorToast(context, description: state.failure.statusCode);
          }
        },
        builder: (context, state) {
          if (state is CartSuccessState) {
            EasyLoading.dismiss();
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                iconTheme: IconThemeData(color: theme.primaryColor),
                title: Text("Cart",
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: theme.primaryColor)),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: state.getCartModel.numOfCartItems == 0
                        ? Center(
                            child: Text(
                              "Your Card Is Empty Try to Add new product\n We have New Special Offers ",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return CartItem(
                                  state.getCartModel.data!.products![index]);
                            },
                            itemCount: state.getCartModel.numOfCartItems),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Total price",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: const Color(0xFF6A6695)),
                          ),
                          Text(
                            "EGP ${state.getCartModel.data?.totalCartPrice}",
                            style: theme.textTheme.bodyMedium,
                          )
                        ],
                      ),
                      Container(
                        width: mediaQuery.width * 0.62,
                        height: mediaQuery.height * 0.07,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: theme.primaryColor),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, PageRouteName.payment,
                                arguments: state.getCartModel);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Check Out",
                                style: theme.textTheme.bodyLarge,
                              ),
                              SizedBox(
                                width: mediaQuery.width * 0.03,
                              ),
                              const Icon(
                                Icons.arrow_right_alt_outlined,
                                color: Colors.white,
                                size: 25,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                      .setVerticalPadding(context, 0.02)
                      .setHorizontalPadding(context, 0.02),
                ],
              ),
            );
          }
          else {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
