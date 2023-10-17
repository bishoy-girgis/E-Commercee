import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Domain/entity/payment/order_id_entity.dart';
import 'package:e_commerce_app/Domain/repositries/payment/payment_repository.dart';

import '../../../Core/error/faliure.dart';

class OrderIdUseCase {
  PaymentRepository paymentRepository;

  OrderIdUseCase(this.paymentRepository);

  Future<Either<Failure, OrderIdEntity>> execute(
          {required String token, required num totalCost}) =>
      paymentRepository.getOrderId(token, totalCost);
}
