class InitPaymentSheetModel {
  final String clientSecret;
  final String customerId;
  final String ephemeralKey;
  final String merchantName;

  InitPaymentSheetModel(
      {required this.clientSecret,
      required this.customerId,
      required this.ephemeralKey,
      required this.merchantName});
}
