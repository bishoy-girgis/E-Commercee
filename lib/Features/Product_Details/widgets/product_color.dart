import 'package:e_commerce_app/Core/extentions/extentions.dart';
import 'package:flutter/material.dart';

class ProductColor extends StatelessWidget {
  final Color color;
  final bool select;
  final Function(bool) onColorSelected;

  ProductColor({
    required this.color,
    required this.select,
    required this.onColorSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Toggle the 'select' property when tapped
        onColorSelected(!select);
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: ShapeDecoration(
          color: color,
          shape: const OvalBorder(),
        ),
        child: select
            ? const Icon(
          Icons.check,
          color: Colors.white,
          size: 20,
        )
            : null,
      ).setHorizontalPadding(context, 0.01),
    );
  }
}