import 'package:e_commerce_app/Core/extentions/extentions.dart';
import 'package:e_commerce_app/Data/data_sources/payment/payment_datasource.dart';
import 'package:e_commerce_app/Features/Cart/manager/cubit.dart';
import 'package:e_commerce_app/Features/Payment/manager/cubit.dart';
import 'package:e_commerce_app/Features/Payment/manager/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Core/config/page_route_name.dart';
import '../../../Core/widgets/custom_textfield.dart';
import '../../../Data/models/cart/get_cart_model.dart';
import '../../../main.dart';

class PaymentView extends StatelessWidget {
  GetCartModel cart;

  PaymentView(this.cart, {super.key});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocProvider(
      create: (context) => PaymentCubit(PaymentRemoteDto()),
      child: BlocConsumer<PaymentCubit, PaymentStates>(
        listener: (context, state) {
          if (state is KoiskPaymentSuccessState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("process is done successfully"),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      textAlign: TextAlign.center,
                        "Please go to the nearest supermarket and pay through machine (Fawry ,Aman) by this number \n  ${state.koiskPaymentEntity.id}"),
                  ),
                    actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context, PageRouteName.home, (route) => false);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                );
              } ,
            );
          } else  if (state is VisaPaymentSuccessState){
            Navigator.pushNamed(context, PageRouteName.webView);
          }
        },
        builder: (context, state) {
          var cubit = PaymentCubit.get(context);
          return Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                iconTheme: IconThemeData(color: theme.primaryColor),
                title: Text("Check out",
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: theme.primaryColor)),
              ),
              body: Center(
                child: Stepper(
                  onStepContinue: () {
                    if (formKey.currentState!.validate()) {
                      cubit.StepContinue(cart.data?.totalCartPrice ?? 0);
                    }
                  },
                  onStepCancel: () => cubit.StepCancel(),
                  type: StepperType.vertical,
                  currentStep: cubit.currentStepperIndex,
                  onStepTapped: (index) {
                    cubit.onStepTap(index);
                  },
                  steps: [
                    Step(
                      isActive: cubit.currentStepperIndex == 0,
                      title: Row(
                        children: [
                          Icon(
                            Icons.checklist_outlined,
                            color: theme.primaryColor,
                            size: 25,
                          ),
                          Text(
                            "   Fill Information",
                            style: theme.textTheme.bodySmall,
                          )
                        ],
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "First name",
                            style: theme.textTheme.bodyMedium,
                          ),
                          CustomTextField(
                            radiusBorder: 30,
                            onValidate: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return "you must enter your First Name";
                              } else {
                                return null;
                              }
                            },
                            hint: "enter your first name",
                            controller: cubit.firstName,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Last name",
                            style: theme.textTheme.bodyMedium,
                          ),
                          CustomTextField(
                            radiusBorder: 30,
                            onValidate: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return "you must enter your Last Name";
                              } else {
                                return null;
                              }
                            },
                            hint: "enter your last name",
                            controller: cubit.lastName,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Email Address",
                            style: theme.textTheme.bodyMedium,
                          ),
                          CustomTextField(
                            radiusBorder: 30,
                            onValidate: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return "you must enter your email";
                              } else {
                                return null;
                              }
                            },
                            hint: "enter your email",
                            controller: cubit.email,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Phone Number",
                            style: theme.textTheme.bodyMedium,
                          ),
                          CustomTextField(
                            radiusBorder: 30,
                            onValidate: (String? value) {
                              if (value == null || value.trim().isEmpty) {
                                return "you must enter your phone number";
                              } else {
                                return null;
                              }
                            },
                            hint: "enter your phone number",
                            controller: cubit.phoneNumber,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ).setHorizontalPadding(context, 0.01),
                    ),
                    Step(
                      isActive: cubit.currentStepperIndex == 1,
                      title: Row(
                        children: [
                          Icon(
                            CupertinoIcons.creditcard,
                            color: theme.primaryColor,
                            size: 25,
                          ),
                          Text(
                            "   Payment",
                            style: theme.textTheme.bodySmall,
                          )
                        ],
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "How do you Like to pay ${cart.data?.totalCartPrice} EGP ?",
                            style: theme.textTheme.bodyMedium,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          ListTile(
                            title: Text(
                              "Visa",
                              style: theme.textTheme.bodyMedium,
                            ),
                            leading: Checkbox(
                              activeColor: theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  side: const BorderSide(width: 2)),
                              value: cubit.visaSelected,
                              onChanged: (value) {
                                cubit.selectVisa(value!);
                              },
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Machine (Fawry , Aman)",
                              style: theme.textTheme.bodySmall,
                            ),
                            leading: Checkbox(
                              activeColor: theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  side: const BorderSide(width: 2)),
                              value: cubit.kioskSelected,
                              onChanged: (value) {
                                cubit.selectKoisk(value!);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
