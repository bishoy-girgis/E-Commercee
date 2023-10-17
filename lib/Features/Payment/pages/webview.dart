import 'package:e_commerce_app/Core/constants/constants.dart';
import 'package:e_commerce_app/Data/data_sources/payment/payment_datasource.dart';
import 'package:e_commerce_app/Features/Payment/manager/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../Data/data_sources/cart/cart_data_source.dart';
import '../manager/states.dart';

class WebView extends StatelessWidget {
  WebView({super.key});

  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate())
      ..loadRequest(Uri.parse(
          "https://accept.paymob.com/api/acceptance/iframes/795034?payment_token=${Constants.token}"));

    return  Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text("Visa Card",
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          body: WebViewWidget(controller: controller)),
    );

  }
}
