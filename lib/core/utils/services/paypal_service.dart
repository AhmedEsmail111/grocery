import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

import '../../models/payment/amount_model.dart';
import '../../models/payment/items_list_model.dart';
import '../api_keys.dart';

class PaypalService {
  Widget makePaypalPayment({
    // required Map<String, dynamic> transactionData,
    required BuildContext context,
    required AmountModel amount,
    required ItemsListModel items,
    required void Function() onSuccess,
  }) {
    return PaypalCheckoutView(
      sandboxMode: true,
      clientId: paypalClientId,
      secretKey: paypalSecretKey,
      transactions: [
        {
          "amount": amount.toJson(),
          "description": "The payment transaction description.",
          "item_list": items.toJson(),
        }
      ],
      note: "Contact us for any questions on your order.",
      onSuccess: (Map params) async {
        log("onSuccess: $params");
        onSuccess();

        Navigator.pop(context);
      },
      onError: (error) {
        log("onError: $error");
        Navigator.pop(context);
      },
      onCancel: () {
        log('cancelled:');
        Navigator.pop(context);
      },
    );
  }
}
