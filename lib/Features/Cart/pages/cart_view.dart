import 'package:e_commerce_app/Core/config/page_route_name.dart';
import 'package:e_commerce_app/Core/extentions/extentions.dart';
import 'package:e_commerce_app/Data/data_sources/cart/cart_data_source.dart';
import 'package:e_commerce_app/Features/Cart/manager/cubit.dart';
import 'package:e_commerce_app/Features/Cart/manager/states.dart';
import 'package:e_commerce_app/Features/Cart/widgets/cart_item.dart';
import 'package:e_commerce_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => CartCubit(CartRemoteDto())..getCart(),
      child: BlocConsumer<CartCubit, CartStates>(
        builder: (context, state) {
          if (state is CartSuccessState) {
            return Scaffold(
              appBar: AppBar(
                // actions: [
                //   IconButton(onPressed: () {
                //
                //   }, icon: const Icon(Icons.delete,color: Colors.blueGrey,size: 25,))
                // ],
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
                    child: ListView.builder(
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
                            Navigator.pushNamed(context, PageRouteName.payment,arguments: state.getCartModel);
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
          } else {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
        listener: (context, state) {
          if (state is CartLoadingState) {
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
          } else if (state is CartErrorState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: Text("Errorrr"),
                content: Text(state.failure.statusCode ?? ""),
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
          }
        },
      ),
    );
  }
}
