import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

successToast(context,{String? title,String? description}){
  MotionToast.success(
    width: 330.w,
    height: 80.h,
    title: Text("${title}"),
    description: Text("${description}"),
    animationType: AnimationType.fromTop,
    position: MotionToastPosition.top,
  ).show(context);

}

  errorToast(context,{String? title,String? description}){
    MotionToast.error(
      height: 80.h,
      title: Text("Error"),
      description:  Text("${description}"),
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.top,
    ).show(context);

  }