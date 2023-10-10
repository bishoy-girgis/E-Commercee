import 'package:flutter/cupertino.dart';

extension CenterToWidget on Widget{
  Widget SetCenter(){
    return Center(
      child: this,
    );
  }
}