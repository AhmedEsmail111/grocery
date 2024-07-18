class PaymentIntentInputModel {
  final String amount;
  final String currency;
  final String customerId;

  PaymentIntentInputModel({
    required this.amount,
    required this.currency,
    required this.customerId,
  });

  toJson() {
    var intAmount = int.tryParse(amount);
    if (intAmount != null) {
      intAmount = intAmount * 100;
    }

    return {
      'amount': '$intAmount',
      'currency': currency,
      'customer': customerId,
    };
  }
}
