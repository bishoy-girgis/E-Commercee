import 'package:flutter/cupertino.dart';

class User {
  String? userName;
  String? email;
  String? token;

  User._({this.userName, this.email, this.token});

  static User? _this;

  factory User() {
    _this ??= User._();
    return _this!;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    if (_this == null) {
      _this = User._(
        userName: json["user"]["name"],
        email: json["user"]["email"],
        token: json["token"],
      );
    } else {
      _this?.userName = json["user"]["name"];
      _this?.email = json["user"]["email"];
      _this?.token = json["token"];
    }
    return _this!;
  }

  static printUser() {
    debugPrint(_this!.userName);
    debugPrint(_this!.email);
    debugPrint(_this!.token);
  }

  clearUser() {
    userName = null;
    email = null;
    token = null;
  }
}
