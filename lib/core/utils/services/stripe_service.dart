import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../models/payment/create_customer_input_model.dart';
import '../../models/payment/customer_object_model.dart';
import '../../models/payment/ephemeral_key_model.dart';
import '../../models/payment/init_payment_sheet_model.dart';
import '../../models/payment/payment_intent_input_model.dart';
import '../../models/payment/payment_intent_object.dart';
import '../api_end_points.dart';
import '../api_keys.dart';
import 'api_service.dart';

class StripeService {
  final ApiService apiService;

  StripeService({required this.apiService});
  Future<PaymentIntentObject> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var response = await apiService.post(
      body: paymentIntentInputModel.toJson(),
      endPoint: createPaymentIntentUrl,
      token: 'Bearer $secretKey',
      contentType: 'application/x-www-form-urlencoded',
    );

    var paymentIntentObject = PaymentIntentObject.fromJson(response.data);
    log('the response of create payment intent ${response.data}');
    return paymentIntentObject;
  }

  Future initPaymentSheet(
      {required InitPaymentSheetModel initPaymentSheetModel}) async {
    await Stripe.instance
        .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: initPaymentSheetModel.clientSecret,
            merchantDisplayName: initPaymentSheetModel.merchantName,
            customerId: initPaymentSheetModel.customerId,
            customerEphemeralKeySecret: initPaymentSheetModel.ephemeralKey,
            style: ThemeMode.light,
          ),
        )
        .then((value) => log('done initing the payment'));
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  // creates a customer only one time when he creates an account in the app
  Future<CustomerObjectModel> createCustomer(
      CreateCustomerInputModel createCustomerInputModel) async {
    var response = await apiService.post(
        body: createCustomerInputModel.toJson(),
        endPoint: 'https://api.stripe.com/v1/customers',
        token: 'Bearer $secretKey',
        contentType: 'application/x-www-form-urlencoded');

    var customerObject = CustomerObjectModel.fromJson(response.data);

    return customerObject;
  }

  // create an ephemeral key for a customer(each payment process)
  Future<EphemeralKeyObjectModel> createEphemeralKey(
      {required customerId}) async {
    var response = await apiService.post(
      body: {'customer': customerId},
      endPoint: createEphemeralKeyUrl,
      token: 'Bearer $secretKey',
      contentType: 'application/x-www-form-urlencoded',
      stripeVersion: '2023-10-16',
    );

    var ephemeralKeyObject = EphemeralKeyObjectModel.fromJson(response.data);
    log('the response of create ephemeral key ${response.data}');
    return ephemeralKeyObject;
  }

// the main entry execution point for a payment process
  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentObject =
        await createPaymentIntent(paymentIntentInputModel);

    var ephemeralKeyObject = await createEphemeralKey(
        customerId: paymentIntentInputModel.customerId);

    await initPaymentSheet(
      initPaymentSheetModel: InitPaymentSheetModel(
        clientSecret: paymentIntentObject.clientSecret!,
        customerId: paymentIntentInputModel.customerId,
        ephemeralKey: ephemeralKeyObject.secret,
        merchantName: 'MarketOnline',
      ),
    );

    await displayPaymentSheet();
  }
}
