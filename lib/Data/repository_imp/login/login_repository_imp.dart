import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/Data/data_sources/login/login_datasource.dart';
import 'package:e_commerce_app/Data/models/login/forgot_password_model.dart';
import 'package:e_commerce_app/Domain/repositries/login/login_repository.dart';

import '../../../Core/error/faliure.dart';
import '../../../Core/services/user.dart';

class LoginRepositoryImp implements LoginRepository {
  LoginDataSource loginDataSource;

  LoginRepositoryImp(this.loginDataSource);

  @override
  Future<Either<Failure, User>> login(String userName, String password) async {
    try {
      var result = await loginDataSource.login(userName, password);

      if (result.statusCode == 200 && result.data["message"] == "success") {
        User user = User.fromJson(result.data);
        return Right(user);
      } else {
        return Left(
          ServerFailure(
            statusCode: result.statusCode.toString(),
          ),
        );
      }
    } catch (e) {
      DioException error = e as DioException;

      if (error.response?.statusCode == 401) {
        return left(
          ServerFailure(
            statusCode: error.response?.statusCode.toString() ?? "",
            message: error.response?.data["message"],
          ),
        );
      } else {
        return left(ServerFailure(
          statusCode: error.response?.statusCode.toString() ?? "",
          message: error.response?.data["errors"]["msg"],
        ));
      }
    }
  }

  @override
  Future<Either<Failure, ForgotPasswordModel>> forgotPassword(
      String email) async {
    try {
      var result = await loginDataSource.forgotPassword(email);

      ForgotPasswordModel user = ForgotPasswordModel.fromJson(result.data);
      return Right(user);
    } catch (e) {
      DioException error = e as DioException;

      return left(
        ServerFailure(
          statusCode: error.response?.statusCode.toString() ?? "",
          message: error.response?.data["message"],
        ),
      );
    }
  }
}
// print("${error.response} ................................");
// String errorMessage = "An error occurred";
// if (error.response != null) {
//   final responseData = error.response?.data;
//
//   if (responseData != null) {
//     if (responseData is Map<String, dynamic>) {
//       if (responseData.containsKey("errors") &&
//           responseData["errors"] is Map<String, dynamic>) {
//         final errors = responseData["errors"];
//         if (errors.containsKey("msg")) {
//           errorMessage = errors["msg"].toString();
//         }
//       } else if (responseData.containsKey("message")) {
//         errorMessage = responseData["message"].toString();
//       }
//     } else if (responseData is String) {
//       errorMessage = responseData;
//     }
//   }
// }
// return Left(ServerFailure(
//   statusCode: error.response?.statusCode.toString() ?? "Unknown",
//   message: errorMessage,
// ));
