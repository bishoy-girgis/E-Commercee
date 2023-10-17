import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Domain/entity/payment/auth_request_token_entity.dart';
import 'package:e_commerce_app/Domain/entity/payment/koisk_payment_entity.dart';
import 'package:e_commerce_app/Domain/entity/payment/order_id_entity.dart';


abstract class PaymentRepository{

  Future<Either<Failure,AuthAndRequestTokenEntity>> getAuthToken();
  Future<Either<Failure,OrderIdEntity>> getOrderId(String token,num totalCost);
  Future<Either<Failure,AuthAndRequestTokenEntity>> requestToken(Object data);
  Future<Either<Failure,KoiskPaymentEntity>> koiskPayment(String paymentToken);


}