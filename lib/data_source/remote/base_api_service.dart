import 'package:order_booking/data_source/remote/response/api_response.dart';

abstract class BaseApiService{

  // Generic methods for Get and Post Request
  Future<ApiResponse> makeGetRequest(String path, Map<String, String> headers,
      Map<String, dynamic>? queryParameters);

  Future<ApiResponse> makePostRequest(String path, Object body,
      Map<String, String> headers, Map<String, dynamic>? queryParameters);
}