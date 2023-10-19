import 'package:e_commerce_app/Core/extentions/extentions.dart';
import 'package:e_commerce_app/Data/data_sources/home/home_datasource.dart';
import 'package:e_commerce_app/Domain/entity/home/product_entity.dart';
import 'package:e_commerce_app/Features/Home/manager/states.dart';
import 'package:e_commerce_app/Features/Product_Details/widgets/product_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Core/services/toast.dart';
import '../../Home/manager/cubit.dart';
import '../widgets/add_to cart.dart';
import '../widgets/color_and_size.dart';
import '../widgets/product_title_with_image.dart';

class ProductDetailsView extends StatefulWidget {
  ProductDataEntity product;

  ProductDetailsView(this.product, {super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  List<Color> colors = [
    Colors.black,
    Colors.grey,
    Colors.red,
    Colors.blue,
    Colors.green,
  ];

  int selectedColorIndex = -1;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return BlocProvider(
      create: (context) => HomeCubit(HomeRemoteDto()),
      child: BlocConsumer<HomeCubit, HomeStates>(
        builder: (context, state) {
          return Scaffold(
            // each product have a color
            backgroundColor: theme.primaryColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.white),
              title: Text("Product Details",
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.white)),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: mediaQuery.height,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin:
                              EdgeInsets.only(top: mediaQuery.height * 0.35),
                          padding: EdgeInsets.only(
                            top: mediaQuery.height * 0.08,
                            left: 20,
                            right: 20,
                          ),
                          height: mediaQuery.height,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Total price",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                      color: const Color(0xFF6A6695)),
                                ),
                                Text(
                                  "EGP ${widget.product.price}",
                                  style: theme.textTheme.headlineMedium,
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          border: Border.all(
                                              color: Colors.blueGrey,
                                              width: 1)),
                                      child: Text(
                                        " ${widget.product.sold} Sold",
                                        style: theme.textTheme.bodySmall,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 38.w,
                                    ),
                                    Row(
                                      children: [
                                        const ImageIcon(
                                            AssetImage(
                                                "assets/images/icons/star.png"),
                                            size: 17,
                                            color: Color(0XFFFDD835)),
                                        Text(
                                          widget.product.ratingsAverage
                                              .toString(),
                                          style: theme.textTheme.displaySmall,
                                        ),
                                        Text(
                                          " (${widget.product.ratingsQuantity})",
                                          style: theme.textTheme.displaySmall,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 38.w,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          color: theme.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          border: Border.all(
                                              color: Colors.blueGrey,
                                              width: 1)),
                                      child: Row(
                                        children: [
                                          const Icon(
                                              CupertinoIcons.minus_circle,
                                              color: Colors.white),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text("1",
                                              style: theme.textTheme.bodyLarge),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          const Icon(
                                            CupertinoIcons.add_circled,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                const ColorAndSize(),
                                SizedBox(height: 10.h),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Text(
                                    widget.product.description ?? "",
                                    style: const TextStyle(height: 1.5),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                AddToCart(widget.product)
                              ],
                            ),
                          ),
                        ),
                        ProductTitleWithImage(product: widget.product)
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is AddToCartSuccessState) {
            successToast(context,
                description: "Added To Cart Successfully", title: "Cart");
          }
        },
      ),
    );
  }
}
