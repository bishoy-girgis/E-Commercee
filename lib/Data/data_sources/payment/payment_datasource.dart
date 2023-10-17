import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/Data/models/payment/auth_request_token_model.dart';
import 'package:e_commerce_app/Data/models/payment/koisk_payment_model.dart';
import 'package:e_commerce_app/Data/models/payment/order_id_model.dart';

import '../../../Core/constants/constants.dart';
import '../../../Core/error/faliure.dart';

abstract class PaymentDataSource{

  Future<Either<Failure,AuthAndRequestTokenModel>> getAuthToken();
  Future<Either<Failure,OrderIdModel>> getOrderId(String token,num totalCost);
  Future<Either<Failure,AuthAndRequestTokenModel>> requestToken(Object data);
  Future<Either<Failure,KoiskPaymentModel>> koiskPayment(String paymentToken);
}

class PaymentRemoteDto implements PaymentDataSource {
  Dio dio = Dio();
  @override
  Future<Either<Failure, AuthAndRequestTokenModel>> getAuthToken() async{
    try {
      var response = await dio.post(
        "${Constants.paymentBaseUrl}/api/auth/tokens",
        data: {
          "api_key": Constants.ApiKey
        }
      );
      AuthAndRequestTokenModel model = AuthAndRequestTokenModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(statusCode: e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderIdModel>> getOrderId(String token,num totalCost) async{
    try {
      var response = await dio.post(
          "${Constants.paymentBaseUrl}/api/ecommerce/orders",
          data: {
            "auth_token": token ,
            "delivery_needed": "false",
            "amount_cents": totalCost*100,
            "currency": "EGP",
            "items": []
          }
      );
      OrderIdModel model = OrderIdModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(statusCode: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthAndRequestTokenModel>> requestToken(Object data)async {
    try {
      var response = await dio.post(
          "${Constants.paymentBaseUrl}/api/acceptance/payment_keys",
          data: data
      );
      AuthAndRequestTokenModel model = AuthAndRequestTokenModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(statusCode: e.toString()));
    }
  }

  @override
  Future<Either<Failure, KoiskPaymentModel>> koiskPayment(String paymentToken) async{
    try {
      var response = await dio.post(
          "${Constants.paymentBaseUrl}/api/acceptance/payments/pay",
          data: {
            "source": {
              "identifier": "AGGREGATOR",
              "subtype": "AGGREGATOR"
            },
            "payment_token": paymentToken
          }
      );
      KoiskPaymentModel model = KoiskPaymentModel.fromJson(response.data);
      return Right(model);
    } catch (e) {
      return left(ServerFailure(statusCode: e.toString()));
    }
  }


}