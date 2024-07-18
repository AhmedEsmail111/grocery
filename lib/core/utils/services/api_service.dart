import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService({required Dio dio}) : _dio = dio;

  Future<Response> post({
    required body,
    String? token,
    required String endPoint,
    String? contentType,
    String? stripeVersion,
  }) async {
    return _dio.post(
      endPoint,
      data: body,
      options: Options(
        contentType: contentType ?? 'application/json',
        headers: {
          'Authorization': token,
          if (stripeVersion != null) 'Stripe-Version': stripeVersion
        },
      ),
    );
  }

  Future<Map<String, dynamic>> get({
    body,
    String? token,
    required String endPoint,
    String? contentType,
    required String stripeVersion,
  }) async {
    final response = await _dio.get(
      endPoint,
      data: body,
      options: Options(
        contentType: contentType ?? 'application/json',
        headers: {'Authorization': token, 'Stripe-Version': stripeVersion},
      ),
    );
    return response.data;
  }
}
