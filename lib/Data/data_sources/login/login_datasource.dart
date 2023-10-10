import 'package:dio/dio.dart';

class LoginDataSource {
  final Dio dio;

  LoginDataSource(this.dio);

  Future<Response> login(String userName, String password) {
    return dio.post("/api/v1/auth/signin", data: {
      "email": userName,
      "password": password,
    });
  }
}
