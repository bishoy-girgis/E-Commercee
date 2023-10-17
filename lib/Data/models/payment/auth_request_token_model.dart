import 'package:e_commerce_app/Domain/entity/payment/auth_request_token_entity.dart';

class AuthAndRequestTokenModel extends AuthAndRequestTokenEntity {
  AuthAndRequestTokenModel({
    super.token,
  });

  AuthAndRequestTokenModel.fromJson(dynamic json) {
    token = json['token'];
  }
}
