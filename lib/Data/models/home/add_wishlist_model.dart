import 'package:e_commerce_app/Domain/entity/home/add_wishlist_entity.dart';

/// status : "success"
/// message : "Product added successfully to your wishlist"
/// data : ["6428ebc6dc1175abc65ca0b9","6428eb43dc1175abc65ca0b3"]

class AddWishlistModel extends AddWishlistEntity{
  AddWishlistModel({
      super.status,
      super.message,
      super.data,});

  AddWishlistModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? json['data'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['data'] = data;
    return map;
  }

}