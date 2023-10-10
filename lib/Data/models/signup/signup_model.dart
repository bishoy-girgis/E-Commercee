import 'package:e_commerce_app/Domain/entity/signup/sign_up_entity.dart';

class SignUpModel extends SignUpEntity {
  const   SignUpModel({
    required super.userName,
    required super.userEmail,
    required super.token,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      userName: json["user"]["name"],
      userEmail: json["user"]["email"],
      token: json["token"],
    );
  }
}
