import 'package:flutter/cupertino.dart';

class User {
  String? userName;
  String? email;

  User._({this.userName, this.email});

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
      );
    } else {
      _this?.userName = json["user"]["name"];
      _this?.email = json["user"]["email"];
    }
    return _this!;
  }

  static printUser(){
    debugPrint(_this!.userName);
    debugPrint(_this!.email);
  }

  clearUser(){
    userName=null;
    email=null;
  }
}
