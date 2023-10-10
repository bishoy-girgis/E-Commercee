import 'package:dio/dio.dart';
import 'package:e_commerce_app/Data/models/signup/signup_request.dart';

class SignUpDataSource {
  final Dio dio;

  SignUpDataSource(this.dio);

  Future<Response> signUp(SignUpRequestModel data) {
    return dio.post("/api/v1/auth/signup", data: {
      "name": data.name,
      "email": data.email,
      "password": data.password,
      "rePassword": data.rePassword,
      "phone": data.phoneNumber
    });
  }
}



//
//
// import 'package:dio/dio.dart';
// import 'package:e_commerce_app/Data/models/signup/signup_request.dart';
//
// class SignUpDataSource {
//   final Dio dio;
//
//   SignUpDataSource(this.dio);
//
//   Future<Response> signUp(SignUpRequestModel data) async {
//     try {
//       final response = await dio.post("/api/v1/auth/signup",
//           data: {
//         "name": data.name,
//         "email": data.email,
//         "password": data.password,
//         "rePassword": data.rePassword,
//         "phone": data.phoneNumber
//       });
//       print(response);
//       return response;
//     } on DioError catch (e) {
//       // Handle Dio errors here
//       print(e.response);
//       print("Dio Error: ${e.message}");
//       throw e; // Re-throw the DioError to propagate it up the call stack if needed.
//     } catch (e) {
//       // Handle other types of errors here
//       print("Other Error: $e");
//       throw e; // Re-throw the error to propagate it up the call stack if needed.
//     }
//   }
// }
