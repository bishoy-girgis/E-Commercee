import 'package:e_commerce_app/Domain/entity/home/update_user_entity.dart';

class UpdateUserModel extends UpdateUserEntity {
  UpdateUserModel({
      super.message,
      super.user,});

  UpdateUserModel.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }


}


class User extends UserUpEntity{
  User({
      super.name,
      super.email,
      this.role,});

  User.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }

  String? role;


}