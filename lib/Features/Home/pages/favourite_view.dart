import 'package:e_commerce_app/Core/extentions/extentions.dart';
import 'package:e_commerce_app/Features/Home/widgets/product_wishlist_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/cubit.dart';
import '../manager/states.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var cubit = HomeCubit.get(context);
    var theme = Theme.of(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child:  cubit.wishListProduct.isEmpty
                  ? Center(
                child: Text(
                  "Your WishList Is Empty Try to Add new product\n We have New Special Offers ",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
                  : ListView.builder(
                  itemBuilder: (context, index) {
                    return ProductWishListItem(
                       cubit.wishListProduct[index]);
                  },
                  itemCount: cubit.wishListProduct.length).setHorizontalPadding(context, 0.025),
            ),
          ],
        );
      },
    );
  }
}
