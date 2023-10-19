import 'package:e_commerce_app/Core/extentions/extentions.dart';
import 'package:e_commerce_app/Features/Home/manager/cubit.dart';
import 'package:e_commerce_app/Features/Home/manager/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../../../Core/widgets/custom_textfield.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var cubit = HomeCubit.get(context);
    var theme = Theme.of(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // if (state is GetCategoryLoadingState) {
        //   Center(
        //     child: CircularProgressIndicator(
        //       backgroundColor: Theme.of(context).primaryColor,
        //     ),
        //   );
        // } else if (state is GetCategoryErrorState) {
        //   Center(child: Text("Error : ${state.failure.statusCode}"));
        // } else if (state is GetCategorySuccessState) {}
      },
      builder: (context, state) {
        return ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hint: "what do you search for?",
                    radiusBorder: 28,
                    prefix: Icon(
                      Icons.search,
                      size: 30,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            ImageSlideshow(
              width: double.infinity,
              height: 200,
              initialPage: 0,
              indicatorColor: theme.primaryColor,
              indicatorBackgroundColor: Colors.white,
              indicatorPadding: 8,
              indicatorBottomPadding: 10,
              indicatorRadius: 5,
              autoPlayInterval: 3000,
              isLoop: true,
              children: cubit.slidesImages,
            ).setVerticalPadding(context, 0.013),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Categories",
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor),
                ),
                // Text(
                //   "View all",
                //   style: theme.textTheme.displaySmall,
                // ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: mediaQuery.width,
              height: mediaQuery.height * 0.3,
              child: GridView.builder(
                itemCount: cubit.categories.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    CircleAvatar(
                      radius: 38,
                      backgroundImage: NetworkImage(
                        cubit.categories[index].image ?? "",
                        scale: 1.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      cubit.categories[index].name ?? "",
                      style: theme.textTheme.displaySmall,
                    ),
                  ],
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 8,
                  crossAxisCount: 2,
                ),
                scrollDirection: Axis.horizontal,
              ),
            ),
            Text(
              "Brands",
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: mediaQuery.width,
              height: mediaQuery.height * 0.31,
              child: GridView.builder(
                itemCount: cubit.brands.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
                        child: Image(
                          image: NetworkImage(
                            cubit.brands[index].image ?? "",
                          ),
                        ),
                      ),
                    ),
                    Text(
                      cubit.brands[index].name ?? "",
                      style: theme.textTheme.displaySmall,
                    ),
                  ],
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 8,
                  crossAxisCount: 2,
                ),
                scrollDirection: Axis.horizontal,
              ),
            )
          ],
        ).setOnlyVerticalPadding(context,right: 0.03,left: 0.03,bottom: 0.05);
      },
    );
  }
}
