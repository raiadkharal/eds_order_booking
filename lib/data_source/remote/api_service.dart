import 'dart:convert';

import 'package:order_booking/data_source/remote/base_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:order_booking/data_source/remote/response/api_response.dart';

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
       return ApiResponse.error(error.toString());
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
       return ApiResponse.error(error.toString());
     }
   }

   // api response handling
   ApiResponse handleApiResponse(http.Response response) {
     switch (response.statusCode) {
       case 200:
         return ApiResponse.success(response.body);
       case 401:
         return ApiResponse.error("UnAuthorized");
       case 400:
         return ApiResponse.error("Username or Password Incorrect");
       case 408:
         return ApiResponse.error("Request Timed out");
       case 500:
         return ApiResponse.error("Internal Server Error");
       default:
         return ApiResponse.error(Constants.GENERIC_ERROR);
     }
   }

}