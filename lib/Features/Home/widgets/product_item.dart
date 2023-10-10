import 'package:e_commerce_app/Core/extentions/extentions.dart';
import 'package:e_commerce_app/Domain/entity/home/product_entity.dart';
import 'package:e_commerce_app/Features/Home/manager/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  ProductDataEntity product;

  ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.blueGrey, width: 1.5)),
      height: mq.height * 0.45,
      width: mq.width * 0.45,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: mq.height * 0.2,
                width: mq.width * 0.445,
                child: Image.network(
                  product.imageCover ?? "",
                  scale: 1.8,
                  fit: BoxFit.cover,
                ).SetCenter(),
              ),
              Text(
                product.title ?? "",
                maxLines: 2,
                style: theme.textTheme.bodySmall,
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                "${product.description}...",
                style: theme.textTheme.displaySmall,
              ),
              Row(
                children: [
                  Text(
                    "EGP ${product.price.toString()}",
                    style: theme.textTheme.bodySmall,
                  ),
                  SizedBox(width: mq.width * 0.07),
                  Text(
                    "${(product.price! + product.price! * 0.25).toStringAsFixed(0)} EGP",
                    style: theme.textTheme.displaySmall?.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: const Color(0XFF004182),
                    ),
                  ),
                ],
              ).setVerticalPadding(context, 0.01),
              Row(
                children: [
                  Text(
                    "Review  (${product.ratingsAverage})",
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: mq.width * 0.01,
                  ),
                  const ImageIcon(AssetImage("assets/images/icons/star.png"),
                      size: 17, color: Color(0XFFFDD835)),
                  SizedBox(
                    width: mq.width * 0.025,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: () {
                        HomeCubit.get(context).addToCart(product.id ?? "");
                      },
                      icon: const Icon(Icons.add_circle),
                      color: theme.primaryColor,
                      iconSize: 30,
                    ),
                  ),
                ],
              ),
            ],
          ).setHorizontalPadding(context, 0.01),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                HomeCubit.get(context).addToWishList(product.id ??"");

              },
              child: Image(
                image: const AssetImage("assets/images/icons/select_fav.png"),
                width: mq.width * 0.1,
                height: mq.height * 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
