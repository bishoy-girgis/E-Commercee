import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Data/data_sources/signup/signup_datasource.dart';
import 'package:e_commerce_app/Data/models/signup/signup_model.dart';
import 'package:e_commerce_app/Data/models/signup/signup_request.dart';
import 'package:e_commerce_app/Domain/entity/signup/sign_up_entity.dart';
import 'package:e_commerce_app/Domain/repositries/signup/signup_repository.dart';

class SignUpRepositoryImp implements SignUpRepository {
  final SignUpDataSource _dataSource;

  SignUpRepositoryImp(this._dataSource);

  @override
  Future<Either<Failure, SignUpEntity>> signUp(SignUpRequestModel data) async {
    try {
      var result = await _dataSource.signUp(data);

      if (result.statusCode == 201 && result.data["message"] == "success") {
        var signUpModel = SignUpModel.fromJson(result.data);
        return Right(signUpModel);
      } else if (result.statusCode == 400 && result.data["message"] == "fail") {
        return Left(
          ServerFailure(
              statusCode: result.statusCode.toString(),
              message: result.data["errors"]["msg"]),
        );
      } else {
        return Left(
          ServerFailure(
            statusCode: result.statusCode.toString(),
            message: result.data["statusMsg"],
          ),
        );
      }
    } catch (e) {
      DioException error = e as DioException;

      if (error.response?.statusCode == 409) {
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
}
//{
//       DioException error = e as DioException ;
//
//       print("${error.response} ................................");
//
//       String errorMessage = "An error occurred"; // Default error message
//
//       if (error.response != null) {
//         final responseData = error.response?.data;
//
//         if (responseData != null) {
//           if (responseData is Map<String, dynamic>) {
//             if (responseData.containsKey("errors") && responseData["errors"] is Map<String, dynamic>) {
//               final errors = responseData["errors"];
//               if (errors.containsKey("msg")) {
//                 errorMessage = errors["msg"].toString();
//               }
//             } else if (responseData.containsKey("message")) {
//               errorMessage = responseData["message"].toString();
//             }
//           } else if (responseData is String) {
//             errorMessage = responseData;
//           }
//         }
//       }
//
//       return Left(ServerFailure(
//         statusCode: error.response?.statusCode.toString() ?? "Unknown",
//         message: errorMessage,
//       ));
//     }
