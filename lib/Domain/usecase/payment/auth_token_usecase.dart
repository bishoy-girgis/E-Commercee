import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/Core/error/faliure.dart';
import 'package:e_commerce_app/Domain/entity/payment/auth_request_token_entity.dart';
import 'package:e_commerce_app/Domain/repositries/payment/payment_repository.dart';

class AuthTokenUseCase {
  PaymentRepository paymentRepository;

  AuthTokenUseCase(this.paymentRepository);

  Future<Either<Failure, AuthAndRequestTokenEntity>> execute() =>
      paymentRepository.getAuthToken();
}
