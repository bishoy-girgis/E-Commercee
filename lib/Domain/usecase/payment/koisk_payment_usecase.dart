import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Domain/entity/payment/koisk_payment_entity.dart';
import 'package:e_commerce_app/Domain/repositries/payment/payment_repository.dart';

import '../../../Core/error/faliure.dart';

class KoiskPaymentUseCase {
  PaymentRepository paymentRepository;

  KoiskPaymentUseCase(this.paymentRepository);

  Future<Either<Failure, KoiskPaymentEntity>> execute(
          {required String paymentToken}) =>
      paymentRepository.koiskPayment(paymentToken);
}
