import 'package:e_commerce_app/Core/constants/constants.dart';
import 'package:e_commerce_app/Data/data_sources/payment/payment_datasource.dart';
import 'package:e_commerce_app/Data/repository_imp/payment/payment_repository_imp.dart';
import 'package:e_commerce_app/Domain/repositries/payment/payment_repository.dart';
import 'package:e_commerce_app/Domain/usecase/payment/auth_token_usecase.dart';
import 'package:e_commerce_app/Domain/usecase/payment/koisk_payment_usecase.dart';
import 'package:e_commerce_app/Domain/usecase/payment/order_id_usecase.dart';
import 'package:e_commerce_app/Domain/usecase/payment/request_token_usecase.dart';
import 'package:e_commerce_app/Features/Payment/manager/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentDataSource paymentDataSource;
  late PaymentRepository paymentRepository;

  PaymentCubit(this.paymentDataSource) : super(PaymentInitState()) {
    paymentRepository = PaymentRepositoryImp(paymentDataSource);
  }

  static PaymentCubit get(context) => BlocProvider.of(context);

   String authToken = "";
   String orderId = "";
   double integrationCardId=4286732;
   double integrationKioskId=4286873;
  double integrationId=0;
   String requestTokenCard="";
   String requestTokenKiosk="";

  int currentStepperIndex = 0;
  bool visaSelected = false;
  bool kioskSelected = false;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();


  onStepTap(int index) {
    currentStepperIndex = index;
    emit(ChangeStepperIndexState());
  }

  selectVisa(bool value) {
    visaSelected = value;
    kioskSelected = false;
    emit(ChangePayMethodVisaState());
    integrationId = integrationCardId;
  }

  selectKoisk(bool value) {
    visaSelected = false;
    kioskSelected = value;
    emit(ChangePayMethodKoiskState());
    integrationId= integrationKioskId;
  }

  StepContinue(num totalCost) {
    if (currentStepperIndex != 1) {
      currentStepperIndex += 1;
      emit(ChangeStepperIndexState());
    }
    getAuthToken(totalCost);
  }

  StepCancel() {
    if (currentStepperIndex != 0) {
      currentStepperIndex -= 1;
      emit(ChangeStepperIndexState());
    }
  }

  getAuthToken(num totalCost)async {
    emit(AuthTokenLoadingState());
    AuthTokenUseCase authTokenUseCase = AuthTokenUseCase(paymentRepository);
    var result = await authTokenUseCase.execute();
    result.fold((l) {
      print(l.message);
      emit(AuthTokenErrorState());
    }, (data) {
      authToken = data.token ?? "";
      print("Token >>>>>>>>>>>>>>> $authToken");
      emit(AuthTokenSuccessState());
      getOrderId(totalCost);
    });
  }

  getOrderId(num totalCost)async{
    emit(OrderIdLoadingState());
    OrderIdUseCase orderIdUseCase = OrderIdUseCase(paymentRepository);
    var result = await orderIdUseCase.execute(token: authToken,totalCost: totalCost);
    result.fold((l) {
      print(l.message);
      emit(OrderIdErrorState());
    }, (data) {
      orderId = data.id.toString();
      print("Order iDDDD >>>>>>>>>>>>>>> $orderId");
      emit(OrderIdSuccessState());
      requestTokenVisa(totalCost);
    });
  }
  
  requestTokenVisa(num totalCost)async{
    emit(RequestTokenLoadingState());
    RequestTokenUseCase requestTokenUseCase = RequestTokenUseCase(paymentRepository);
    var result = await requestTokenUseCase.execute(data: {
      "auth_token": authToken,
      "amount_cents": totalCost*100 ,
      "expiration": 3600,
      "order_id": orderId,
      "billing_data": {
        "apartment": "NA",
        "email": email.toString(),
        "floor": "NA",
        "first_name": firstName.toString(),
        "street": "NA",
        "building": "NA",
        "phone_number": phoneNumber.toString(),
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": lastName.toString(),
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": integrationId
    });
    result.fold((l) {
      print(l.message);
      emit(RequestTokenErrorState());
    }, (data) {
      emit(RequestTokenSuccessState());
      if(integrationId==4286732){
        requestTokenCard = data.token ??"";
        print("request tokeennnnn VISA CARDDD>>>>>> $requestTokenCard (integrationId : $integrationId) ");
        Constants.token = requestTokenCard;
        emit(VisaPaymentSuccessState());
      } else{
        requestTokenKiosk  = data.token ??"";
        print("request tokeennnnn KOISKKKK >>>>>> $requestTokenKiosk (integrationId : $integrationId) ");
        koiskPayment();
      }
    });
  }


  koiskPayment()async{
    emit(KoiskPaymentLoadingState());
    KoiskPaymentUseCase koiskPaymentUseCase = KoiskPaymentUseCase(paymentRepository);
    var result = await koiskPaymentUseCase.execute(paymentToken: requestTokenKiosk);
    result.fold((l) {
      print(l.message);
      emit(KoiskPaymentErrorState());
    }, (data) {
      print("Order iDDDD yo pay >>>>>>>>>>>>>>> ${data.id}");
      emit(KoiskPaymentSuccessState(data));
    });
  }

}
