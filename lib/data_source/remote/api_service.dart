import 'dart:convert';

import 'package:order_booking/data_source/remote/base_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:order_booking/data_source/remote/response/api_response.dart';
import 'package:order_booking/db/models/log_model/log_model.dart';

import '../../model/master_model/master_model.dart';
import '../../utils/Constants.dart';

class ApiService extends BaseApiService{
   final _httpClient = http.Client();


   @override
   Future<ApiResponse> makeGetRequest(String path, Map<String, String> headers,
       Map<String, dynamic>? queryParameters) async {
     try {
       Uri uri;
       if (queryParameters != null) {
         //parse url string to Uri and add query parameters to Uri
         uri = Uri.parse(Constants.baseUrl + path)
             .replace(queryParameters: queryParameters);
       } else {
         //parse url string to Uri
         uri = Uri.parse(Constants.baseUrl + path);
       }

       // make request to the server
       final response = await _httpClient.get(
         uri,
         headers: headers,
       );
       return handleApiResponse(response);
     } catch (error) {
       return ApiResponse.error(error.toString(),null);
     }
   }

   @override
   Future<ApiResponse> makePostRequest(
       String path,
       Object body,
       Map<String, String> headers,
       Map<String, dynamic>? queryParameters) async {
     try {
       Uri uri;
       if (queryParameters != null) {
         //parse url string to Uri and add query parameters to Uri
         uri = Uri.parse(Constants.baseUrl + path)
             .replace(queryParameters: queryParameters);
       } else {
         //parse url string to Uri
         uri = Uri.parse(Constants.baseUrl + path);
       }

       final response = await _httpClient.post(
         uri,
         headers: headers,
         body: body,
         encoding: Encoding.getByName("utf-8"),
       );
       return handleApiResponse(response);
     } catch (error) {
       return ApiResponse.error(error.toString(),null);
     }
   }

   // api response handling
   ApiResponse handleApiResponse(http.Response response) {
     switch (response.statusCode) {
       case 200:
         return ApiResponse.success(response.body);
       case 401:
         return ApiResponse.error("UnAuthorized",response.statusCode);
       case 400:
         return ApiResponse.error("Bad Request: Status code 400",response.statusCode);
       case 408:
         return ApiResponse.error("Request Timed out",response.statusCode);
       case 500:
         return ApiResponse.error("Internal Server Error",response.statusCode);
       default:
         return ApiResponse.error(Constants.GENERIC_ERROR,response.statusCode);
     }
   }

   @override
   Future<ApiResponse> getAccessToken(
       String type, String username, String password) async {
     Map<String, dynamic> bodyJson = {
       'grant_type': type,
       'username': username,
       'password': password
     };

     final headers = {
       // "Content-Type": "application/x-www-form-urlencoded",
       "Content-Type": "application/json",
     };

     return makePostRequest("token", jsonEncode(bodyJson), headers, null);
   }


   @override
   Future<ApiResponse> updateStartEndStatus(
       LogModel logModel, String accessToken) async {
     final headers = {
       "Content-Type": "application/json;charset=UTF-8",
       "Authorization": "Bearer $accessToken"
     };

     return makePostRequest("AppOpertion/LogStartEnd", jsonEncode(logModel.toJson()), headers, null);
   }

  @override
  Future<ApiResponse> loadTodayRoutesOutlets(String accessToken) async{
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    return makeGetRequest(
        "route/routes", headers, null);
  }

  @override
  Future<ApiResponse> loadTodayPackageProduct(String accessToken)async {
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    return makeGetRequest(
        "route/products", headers, null);
  }

  @override
  Future<ApiResponse> loadPricing(String accessToken) {
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    return makeGetRequest(
        "pricing/get", headers, null);
  }

   @override
  Future<ApiResponse> saveOrder(String accessToken, MasterModel masterModel) async{
     final headers = {
       "Content-Type": "application/json;charset=UTF-8",
       "Authorization": "Bearer $accessToken"
     };

     return makePostRequest("order/PostOrder", jsonEncode(masterModel.toJson()), headers, null);
  }
}