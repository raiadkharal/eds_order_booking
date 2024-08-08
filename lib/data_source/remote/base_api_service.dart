import 'package:order_booking/data_source/remote/response/api_response.dart';
import 'package:order_booking/db/models/log_model/log_model.dart';
import 'package:order_booking/model/master_model/master_model.dart';

abstract class BaseApiService {
  Future<ApiResponse> getAccessToken(
      String type, String username, String password);

  Future<ApiResponse> updateStartEndStatus(
      LogModel logModel, String accessToken);

  Future<ApiResponse> loadTodayRoutesOutlets(String accessToken);

  Future<ApiResponse> loadTodayPackageProduct(String accessToken);

  Future<ApiResponse> loadPricing(String accessToken);

  Future<ApiResponse> saveOrder(String accessToken,MasterModel masterModel);

  // Generic methods for Get and Post Request
  Future<ApiResponse> makeGetRequest(String path, Map<String, String> headers,
      Map<String, dynamic>? queryParameters);

  Future<ApiResponse> makePostRequest(String path, Object body,
      Map<String, String> headers, Map<String, dynamic>? queryParameters);
}
