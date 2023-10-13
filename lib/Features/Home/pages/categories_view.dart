import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("Categories",style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}
