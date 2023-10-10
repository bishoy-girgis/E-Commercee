import 'package:e_commerce_app/Domain/entity/home/category_entity.dart';
import 'package:flutter/foundation.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.title,
    required super.id,
    required super.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      title: json["name"],
      id: json["_id"],
      imageUrl: json["image"],
    );
  }
}
