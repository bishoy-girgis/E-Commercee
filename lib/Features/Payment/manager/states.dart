import 'package:e_commerce_app/Domain/entity/payment/koisk_payment_entity.dart';

abstract class PaymentStates{}

class PaymentInitState extends PaymentStates{}

class AuthTokenLoadingState extends PaymentStates{}
class AuthTokenSuccessState extends PaymentStates{}
class AuthTokenErrorState extends PaymentStates{}

class OrderIdLoadingState extends PaymentStates{}
class OrderIdSuccessState extends PaymentStates{}
class OrderIdErrorState extends PaymentStates{}

class ChangeStepperIndexState extends PaymentStates{}
class ChangePayMethodVisaState extends PaymentStates{}
class ChangePayMethodKoiskState extends PaymentStates{}

class RequestTokenLoadingState extends PaymentStates{}
class RequestTokenSuccessState extends PaymentStates{}
class RequestTokenErrorState extends PaymentStates{}

class KoiskPaymentLoadingState extends PaymentStates{}
class KoiskPaymentSuccessState extends PaymentStates{
  KoiskPaymentEntity koiskPaymentEntity;
  KoiskPaymentSuccessState(this.koiskPaymentEntity);
}
class KoiskPaymentErrorState extends PaymentStates{}

class VisaPaymentSuccessState extends PaymentStates{}