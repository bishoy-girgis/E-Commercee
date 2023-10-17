import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Data/data_sources/payment/payment_datasource.dart';
import 'package:e_commerce_app/Data/models/payment/auth_request_token_model.dart';
import 'package:e_commerce_app/Data/models/payment/koisk_payment_model.dart';
import 'package:e_commerce_app/Data/models/payment/order_id_model.dart';
import 'package:e_commerce_app/Domain/entity/payment/auth_request_token_entity.dart';
import 'package:e_commerce_app/Domain/entity/payment/koisk_payment_entity.dart';
import 'package:e_commerce_app/Domain/entity/payment/order_id_entity.dart';
import 'package:e_commerce_app/Domain/repositries/payment/payment_repository.dart';

class PaymentRepositoryImp implements PaymentRepository{
  PaymentDataSource paymentDataSource;
  PaymentRepositoryImp(this.paymentDataSource);
  @override
  Future<Either<Failure, AuthAndRequestTokenModel>> getAuthToken() {
   return paymentDataSource.getAuthToken();
  }

  @override
  Future<Either<Failure, OrderIdModel>> getOrderId(String token,num totalCost) {
    return paymentDataSource.getOrderId(token, totalCost);
  }

  @override
  Future<Either<Failure, AuthAndRequestTokenModel>> requestToken(Object data) {
    return paymentDataSource.requestToken(data);
  }

  @override
  Future<Either<Failure, KoiskPaymentModel>> koiskPayment(String paymentToken) {
    return paymentDataSource.koiskPayment(paymentToken);
  }



}