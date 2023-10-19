import 'package:e_commerce_app/Core/config/page_route_name.dart';
import 'package:e_commerce_app/Core/extentions/extentions.dart';
import 'package:e_commerce_app/Core/services/cache_helper.dart';
import 'package:e_commerce_app/Core/services/toast.dart';
import 'package:e_commerce_app/Core/services/user.dart';
import 'package:e_commerce_app/Features/Home/manager/cubit.dart';
import 'package:e_commerce_app/Features/Home/manager/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Core/widgets/custom_textfield.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
      if (state is UpdateUserSuccessState) {
        successToast(context,
            title: " Update Profile", description: "done successfully");
        CacheHelper.removeData("username");
        CacheHelper.removeData("usermail");
        CacheHelper.removeData("userphone");
        CacheHelper.saveData(key: "username", value: cubit.nameController.text);
        CacheHelper.saveData(
            key: "usermail", value: cubit.emailController.text);
        CacheHelper.saveData(
            key: "userphone", value: cubit.phoneController.text);
      }
      if (state is UpdateUserErrorState) {
        errorToast(context,
            title: "${state.failure.statusCode}",
            description: "${state.failure.message}");
      }
      if (state is AddAddressErrorState) {
        errorToast(context,
            title: "${state.failure.statusCode}",
            description: "${state.failure.message}");
      }
      if (state is AddAddressSuccessState) {
        successToast(context,
            title: "Address", description: "Added successfully");
      }
    }, builder: (context, state) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 43,
                  backgroundImage:
                      AssetImage("assets/images/icons/profile.jpeg"),
                ).setHorizontalPadding(context, 0.04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${CacheHelper.getData("username")}",
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(
                      "${CacheHelper.getData("usermail")}",
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: Colors.blueGrey),
                    ),
                    // Text(
                    //   "${CacheHelper.getData("userphone")}",
                    //   style: theme.textTheme.bodySmall?.copyWith(color: Colors.blueGrey),
                    // ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Account",
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: const Color(0XFF999BA9)),
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Icon(
                  CupertinoIcons.profile_circled,
                  color: theme.primaryColor,
                  size: 25,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text("Edit Profile", style: theme.textTheme.bodySmall),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      cubit.onEditProfile();
                    },
                    icon: Icon(
                      Icons.arrow_drop_down_sharp,
                      color: theme.primaryColor,
                      size: 25,
                    ))
              ],
            ),
            cubit.editProfile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Full Name",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.blueGrey),
                      ),
                      CustomTextField(
                        hint: "enter your user name",
                        controller: cubit.nameController,
                      ).setOnlyVerticalPadding(context,
                          top: 0.005, bottom: 0.005, left: 0.01, right: 0.01),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "Email Address",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.blueGrey),
                      ),
                      CustomTextField(
                        hint: "enter your email",
                        controller: cubit.emailController,
                      ).setOnlyVerticalPadding(context,
                          top: 0.005, bottom: 0.005, left: 0.01, right: 0.01),
                      Text(
                        "Phone number",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.blueGrey),
                      ),
                      CustomTextField(
                        hint: "enter your phone number",
                        controller: cubit.phoneController,
                      ).setOnlyVerticalPadding(context,
                          top: 0.005, bottom: 0.005, left: 0.01, right: 0.01),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            cubit.updateUser();
                            cubit.onEditProfile();
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blueGrey)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Save New Data"),
                              SizedBox(
                                width: 5.w,
                              ),
                              const Icon(Icons.save_as_outlined),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : const Divider(
                    color: Color(0XFF999BA9),
                    thickness: 0.5,
                  ),
            const Divider(
              color: Color(0XFF999BA9),
              thickness: 0.5,
            ),
            Row(
              children: [
                Icon(
                  CupertinoIcons.location_solid,
                  color: theme.primaryColor,
                  size: 25,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text("Add Address", style: theme.textTheme.bodySmall),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      cubit.onAddAddress();
                    },
                    icon: Icon(
                      Icons.arrow_drop_down_sharp,
                      color: theme.primaryColor,
                      size: 25,
                    ))
              ],
            ),
            cubit.addAddress
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Building Name",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.blueGrey),
                      ),
                       CustomTextField(
                        controller: cubit.buildingNameController,
                        hint: "enter your building name",
                      ).setOnlyVerticalPadding(context,
                          top: 0.005, bottom: 0.005, left: 0.01, right: 0.01),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "Details",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.blueGrey),
                      ),
                       CustomTextField(
                        controller: cubit.buildingDetailsController,
                        hint: "enter your building details",
                      ).setOnlyVerticalPadding(context,
                          top: 0.005, bottom: 0.005, left: 0.01, right: 0.01),
                      Text(
                        "City",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.blueGrey),
                      ),
                       CustomTextField(
                        controller: cubit.buildingCityController,
                        hint: "enter your city",
                      ).setOnlyVerticalPadding(context,
                          top: 0.005, bottom: 0.005, left: 0.01, right: 0.01),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            cubit.onAddAddress();
                            cubit.addUserAddress();
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blueGrey)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Save Address"),
                              SizedBox(
                                width: 5.w,
                              ),
                              const Icon(CupertinoIcons.location_solid),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : const Divider(
                    color: Color(0XFF999BA9),
                    thickness: 0.5,
                  ),
            const Divider(
              color: Color(0XFF999BA9),
              thickness: 1,
            ),
            SizedBox(
              height: 13.h,
            ),
            Text(
              "General",
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: const Color(0XFF999BA9)),
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Icon(
                  Icons.settings,
                  color: theme.primaryColor,
                  size: 25,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text("Settings", style: theme.textTheme.bodySmall),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.arrow_right,
                      color: theme.primaryColor,
                      size: 20,
                    ))
              ],
            ),
            const Divider(
              color: Color(0XFF999BA9),
              thickness: 0.7,
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              children: [
                Icon(
                  Icons.lock,
                  color: theme.primaryColor,
                  size: 25,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text("Security", style: theme.textTheme.bodySmall),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.arrow_right,
                      color: theme.primaryColor,
                      size: 20,
                    ))
              ],
            ),
            const Divider(
              color: Color(0XFF999BA9),
              thickness: 1,
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              children: [
                Icon(
                  Icons.policy_rounded,
                  color: theme.primaryColor,
                  size: 25,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text("Privacy Policy", style: theme.textTheme.bodySmall),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.arrow_right,
                      color: theme.primaryColor,
                      size: 20,
                    ))
              ],
            ),
            const Divider(
              color: Color(0XFF999BA9),
              thickness: 1,
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              children: [
                Icon(
                  Icons.logout,
                  color: theme.primaryColor,
                  size: 25,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text("Log Out", style: theme.textTheme.bodySmall),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      CacheHelper.removeData("user");
                      CacheHelper.removeData("username");
                      CacheHelper.removeData("usermail");
                      Navigator.pushNamedAndRemoveUntil(
                          context, PageRouteName.login, (route) => false);
                    },
                    icon: Icon(
                      Icons.logout_outlined,
                      color: theme.primaryColor,
                      size: 25,
                    ))
              ],
            ),
            const Divider(
              color: Color(0XFF999BA9),
              thickness: 1,
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     CacheHelper.removeData("user");
            //     CacheHelper.removeData("username");
            //     CacheHelper.removeData("usermail");
            //     CacheHelper.removeData("userphone");
            //     Navigator.pushNamedAndRemoveUntil(
            //         context, PageRouteName.login, (route) => false);
            //   },
            //   style: const ButtonStyle(
            //       backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: const [
            //       Text("Log Out"),
            //       Icon(Icons.logout_outlined),
            //     ],
            //   ),
            // )
          ],
        )
            .setHorizontalPadding(context, 0.035)
            .setOnlyVerticalPadding(context, bottom: 0.06),
      );
    });
  }
}
