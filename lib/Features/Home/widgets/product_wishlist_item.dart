import 'package:e_commerce_app/Data/models/cart/get_cart_model.dart';
import 'package:e_commerce_app/Domain/entity/home/get_wishlist_entity.dart';
import 'package:e_commerce_app/Features/Cart/manager/cubit.dart';
import 'package:e_commerce_app/Features/Home/manager/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductWishListItem extends StatelessWidget {
  DataWishListEntity product;

  ProductWishListItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10),
      child: Container(
        width: 380.w,
        height: 100.h,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0x4C004182)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 120.w,
                height: 113.h,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(product.imageCover ?? ""),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Colors.transparent),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 128.w,
              top: 16.h,
              child: Text(
                product.title ?? "",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF06004E),
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0.06,
                  letterSpacing: -0.17,
                ),
              ),
            ),
            Positioned(
              left: 290.w,
              top: 20.h,
              child: InkWell(
                onTap: () {
                  HomeCubit.get(context).deleteWishList(product.id??"");
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const ImageIcon(
                      AssetImage("assets/images/icons/favorite.png"),
                      size: 23,
                      color: Colors.white),
                ),
              ),
            ),
            Positioned(
              left: 151.w,
              top: 41.h,
              child: Text(
                product.brand?.name ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0x9906004E),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0.09,
                  letterSpacing: -0.17,
                ),
              ),
            ),
            Positioned(
                left: 134.w,
                top: 33.h,
                child: Container(
                  width: 10.w,
                  height: 10.h,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF6A6695),
                    shape: OvalBorder(),
                  ),
                )),
            Positioned(
              left: 128.w,
              top: 70.h,
              child: Text(
                'EGP ${product.price}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF06004E),
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0.06,
                  letterSpacing: -0.17,
                ),
              ),
            ),
            Positioned(
              left: 128.w,
              top: 80.h,
              child: Text(
                "${(product.price! + product.price! * 0.25).toStringAsFixed(0)} EGP",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: const Color(0XFF004182),
                    ),
              ),
            ),
            Positioned(
              left: 243.w,
              top: 62.h,
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: Colors.blueGrey, width: 1)),
                child: InkWell(
                    onTap: () {
                      HomeCubit.get(context).addToCart(product.id ?? "");
                    },
                    child: Text(
                      "Add to Cart",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(color: Colors.white),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
