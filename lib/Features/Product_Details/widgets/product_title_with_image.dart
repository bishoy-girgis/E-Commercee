import 'package:e_commerce_app/Core/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../../../Domain/entity/home/product_entity.dart';

class ProductTitleWithImage extends StatelessWidget {
  ProductDataEntity product;
   ProductTitleWithImage({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            product.title??"",
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),

          ImageSlideshow(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      initialPage: 0,
                      indicatorColor: Theme.of(context).primaryColor,
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

        ],
      ),
    );
  }
}