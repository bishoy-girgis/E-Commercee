import 'package:flutter/cupertino.dart';

extension PaddingToWidget on Widget {
  Widget setHorizontalPadding(BuildContext context, double value,
      {bool enableMediaQuery = true}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: enableMediaQuery
              ? MediaQuery.of(context).size.width * value
              : value),
      child: this,
    );
  }

  Widget setVerticalPadding(BuildContext context, double value,
      {bool enableMediaQuery = true}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: enableMediaQuery
              ? MediaQuery.of(context).size.height * value
              : value),
      child: this,
    );
  }

  Widget setOnlyVerticalPadding(BuildContext context,
      { double bottom = 0,double left = 0,double right = 0,double top = 0,bool enableMediaQuery = true}) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: enableMediaQuery
            ? MediaQuery.of(context).size.height * bottom
            : bottom,
          left: enableMediaQuery
              ? MediaQuery.of(context).size.height * left
              : left,
          right: enableMediaQuery
              ? MediaQuery.of(context).size.height * right
              : right,
          top: enableMediaQuery
              ? MediaQuery.of(context).size.height * top
              : top,),
      child: this,
    );
  }
}
