import 'package:e_commerce_app/Core/config/page_route_name.dart';
import 'package:e_commerce_app/Core/extentions/extentions.dart';
import 'package:e_commerce_app/Core/services/cache_helper.dart';
import 'package:e_commerce_app/Core/services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Core/widgets/custom_textfield.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome, ${CacheHelper.getData("username")}",
          style: theme.textTheme.bodyMedium,
        ),
        ElevatedButton(
          onPressed: () {
            CacheHelper.removeData("user");
            CacheHelper.removeData("username");
            CacheHelper.removeData("usermail");
            Navigator.pushNamedAndRemoveUntil(
                context, PageRouteName.login, (route) => false);
          },
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text("Log Out"),
              Icon(Icons.logout_outlined),
            ],
          ),
        ),
        SizedBox(
          height: 25.h,
        ),
        Text(
          "Your full name",
          style: theme.textTheme.bodyMedium,
        ),
        CustomTextField(
          hint: "enter your user name",
          controller:
              TextEditingController(text: "${CacheHelper.getData("username")}"),
        ).setOnlyVerticalPadding(context,
            top: 0.01, bottom: 0.03, left: 0.01, right: 0.01),
        SizedBox(
          height: 25.h,
        ),
        Text(
          "Your Email Address",
          style: theme.textTheme.bodyMedium,
        ),
        CustomTextField(
          hint: "enter your user name",
          controller:
          TextEditingController(text: "${CacheHelper.getData("usermail")}"),
        ).setOnlyVerticalPadding(context,
            top: 0.01, bottom: 0.03, left: 0.01, right: 0.01),
      ],
    ).setHorizontalPadding(context, 0.03);
  }
}
