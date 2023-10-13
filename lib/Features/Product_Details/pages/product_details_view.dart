import 'package:e_commerce_app/Core/extentions/extentions.dart';
import 'package:e_commerce_app/Domain/entity/home/product_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../../Home/manager/cubit.dart';

class ProductDetailsView extends StatelessWidget {
  ProductDataEntity product;

  ProductDetailsView(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: theme.primaryColor),
        title: Text("Product Details",
            style:
                theme.textTheme.bodyLarge?.copyWith(color: theme.primaryColor)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageSlideshow(
              width: double.infinity,
              height: mediaQuery.height * 0.4,
              initialPage: 0,
              indicatorColor: theme.primaryColor,
              indicatorBackgroundColor: Colors.grey,
              indicatorPadding: 8,
              indicatorBottomPadding: 10,
              indicatorRadius: 5,
              autoPlayInterval: 3000,
              isLoop: true,
              children: product.images?.map((imageUrl) {
                    return Image.network(
                        imageUrl); // Convert URL to Image widget
                  }).toList() ??
                  [],
            ).setVerticalPadding(context, 0.013),
            SizedBox(
              height: mediaQuery.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: mediaQuery.width * 0.6,
                  child: Text(
                    product.title ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Text(
                  "EGP  ${product.price}",
                  style: theme.textTheme.bodyMedium,
                )
              ],
            ).setVerticalPadding(context, 0.02),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(color: Colors.blueGrey, width: 1)),
                    child: Text(
                      " ${product.sold} Sold",
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 13,
                      ),
                      const ImageIcon(
                          AssetImage("assets/images/icons/star.png"),
                          size: 17,
                          color: Color(0XFFFDD835)),
                      Text(
                        product.ratingsAverage.toString(),
                        style: theme.textTheme.displaySmall,
                      ),
                      Text(
                        " (${product.ratingsQuantity})",
                        style: theme.textTheme.displaySmall,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(color: Colors.blueGrey, width: 1)),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.minus_circle,
                            color: Colors.white),
                        const SizedBox(
                          width: 15,
                        ),
                        Text("1", style: theme.textTheme.bodyLarge),
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
                ),
              ],
            ),
            Text(
              "Description",
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.left,
            ).setVerticalPadding(context, 0.015),
            Text(
              "Title : ${product.title} \n",
              style: theme.textTheme.displaySmall
                  ?.copyWith(color: Colors.blueGrey),
              maxLines: 8,
            ),
            Text(
              "Description : ${product.description}\n",
              style: theme.textTheme.displaySmall
                  ?.copyWith(color: Colors.blueGrey),
              maxLines: 8,
            ),
          ],
        ).setHorizontalPadding(context, 0.07),
      ),
    );
  }
}
