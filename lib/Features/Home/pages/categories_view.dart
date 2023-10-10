import 'package:e_commerce_app/Core/config/page_route_name.dart';
import 'package:e_commerce_app/Core/extentions/extentions.dart';
import 'package:e_commerce_app/Features/Home/manager/states.dart';
import 'package:e_commerce_app/Features/Home/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../manager/cubit.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var cubit = HomeCubit.get(context);
    var theme = Theme.of(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return cubit.products.isEmpty
            ? const Center(child: CircularProgressIndicator())
            // : Center(
            //     child: ProductItem(cubit.products[0]),
            //   );
            : Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: ProductItem(cubit.products[index]),
                          onTap: () {
                            Navigator.pushNamed(context, PageRouteName.productDetails,arguments: cubit.products[index]);
                          },
                        );
                      },
                      itemCount: cubit.products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 6 / 10,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2),
                    ).setHorizontalPadding(context, 0.005),
                  ),
                ],
              );
      },
    );
  }
}
