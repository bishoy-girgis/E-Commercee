import 'package:e_commerce_app/Core/config/page_route_name.dart';
import 'package:e_commerce_app/Core/extentions/extentions.dart';
import 'package:e_commerce_app/Core/services/cache_helper.dart';
import 'package:e_commerce_app/Core/services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        Text(
          '${CacheHelper.getData("usermail")}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0x9906004E),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            CacheHelper.removeData("user");
            CacheHelper.removeData("username");
            CacheHelper.removeData("usermail");
            Navigator.pushNamedAndRemoveUntil(
                context, PageRouteName.login, (route) => false);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(theme.primaryColor)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text("Log Out"),
              Icon(Icons.logout_outlined),
            ],
          ),
        ),
      ],
    ).setHorizontalPadding(context, 0.03);
  }
}
