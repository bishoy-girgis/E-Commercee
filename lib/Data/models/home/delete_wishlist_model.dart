import 'package:e_commerce_app/Domain/entity/home/delete_wishlist_entity.dart';

class DeleteWishlistModel extends DeleteWishlistEntity{
  DeleteWishlistModel({
      super.status,
      super.message,
      super.data,});

  DeleteWishlistModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? json['data'].cast<String>() : [];
  }


}