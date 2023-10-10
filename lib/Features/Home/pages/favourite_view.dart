import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("FAVOURITE",style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}
