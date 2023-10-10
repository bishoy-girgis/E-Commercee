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
    var cubit = HomeCubit().get(context);
    var theme = Theme.of(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is GetCategoryLoadingState) {
          Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        } else if (state is GetCategoryErrorState) {
          Center(child: Text("Error : ${state.failure.statusCode}"));
        } else if (state is GetCategorySuccessState) {}
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
                Icon(
                  CupertinoIcons.cart,
                  color: theme.primaryColor,
                  size: 30,
                ).setHorizontalPadding(context, 0.018)
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
            Text(
              "Categories",
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: mediaQuery.width,
              height: mediaQuery.height * 0.3,
              child: GridView.builder(
                itemCount: cubit.categoriesList.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        cubit.categoriesList[index].imageUrl,
                        scale: 1.5,
                      ),
                    ),
                    Text(
                      cubit.categoriesList[index].title,
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

          ],
        ).setHorizontalPadding(context, 0.03);
      },
    );
  }
}
