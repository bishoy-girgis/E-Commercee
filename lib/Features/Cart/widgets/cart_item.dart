import 'package:e_commerce_app/Data/models/cart/get_cart_model.dart';
import 'package:e_commerce_app/Features/Cart/manager/cubit.dart';
import 'package:e_commerce_app/Features/Home/manager/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItem extends StatelessWidget {
  Products product;

  CartItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10),
      child: Container(
        width: 400.w,
        height: 110.h,
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
                    image: NetworkImage(product.product?.imageCover ?? ""),
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
                product.product?.title ?? "",
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
              left: 300.w,
              top: 10.h,
              child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: IconButton(
                    onPressed: () {
                      CartCubit.get(context)
                          .deleteItemFromCart(product.product?.id ?? "");
                    },
                    icon: const Icon(CupertinoIcons.delete),
                    iconSize: 25,
                    color: Theme.of(context).primaryColor,
                  )),
            ),
            Positioned(
              left: 151.w,
              top: 47.h,
              child: Text(
                product.product?.brand?.name ?? "",
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
                top: 38.h,
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
              top: 85.h,
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
              left: 255.w,
              top: 64.h,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: Colors.blueGrey, width: 1)),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          int counter = product.count ?? 0;
                          counter--;
                          if (counter < 0) {
                            return;
                          }
                          CartCubit.get(context).updateItemFromCart(
                              id: product.product?.id ?? "", count: counter);
                        },
                        child: const Icon(CupertinoIcons.minus_circle,
                            color: Colors.white)),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(product.count.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 18)),
                    SizedBox(
                      width: 15.w,
                    ),
                    InkWell(
                      onTap: () {
                        int counter = product.count ?? 0;
                        counter++;
                        CartCubit.get(context).updateItemFromCart(
                            id: product.product?.id ?? "", count: counter);
                      },
                      child: const Icon(
                        CupertinoIcons.add_circled,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
