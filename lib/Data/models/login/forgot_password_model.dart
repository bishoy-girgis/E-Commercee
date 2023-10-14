

import '../../../Domain/entity/login/forgot_password_entity.dart';

class ForgotPasswordModel extends ForgotPasswordEntity {
  ForgotPasswordModel({
      super.statusMsg,
      super.message,});

  ForgotPasswordModel.fromJson(dynamic json) {
    statusMsg = json['statusMsg'];
    message = json['message'];
  }




}