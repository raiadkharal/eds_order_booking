import 'dart:convert';

import 'package:get/get.dart';
import 'package:order_booking/db/dao/order_dao.dart';
import 'package:order_booking/db/dao/order_status_dao.dart';

import '../../data_source/remote/api_service.dart';
import '../../data_source/remote/response/api_response.dart';
import '../../db/models/token_response/token_response.dart';
import '../../utils/PreferenceUtil.dart';
import '../../utils/enums.dart';
import '../../utils/event.dart';
import '../../utils/network_manager.dart';

class LoginRepository {
  final ApiService _apiService;
  static LoginRepository? _instance;
  final PreferenceUtil _preferenceUtil;
  final OrderDao _orderDao;
  final OrderStatusDao _statusDao;

  final RxBool _isLoading = false.obs;

  final Rx<Event<String>> _msg = Event("").obs;

  // LoggedInUser? _user;

  LoginRepository._(this._apiService, this._preferenceUtil, this._orderDao, this._statusDao);

  static LoginRepository getInstance(
      ApiService apiService, PreferenceUtil preferenceUtil,OrderDao orderDao,OrderStatusDao statusDao) {
    if (_instance == null) {
      return _instance = LoginRepository._(apiService, preferenceUtil,orderDao,statusDao);
    } else {
      return _instance!;
    }
  }

  void login(String username, String password,
      Function(bool success) successCallback) {

    setLoading(true);
    NetworkManager.getInstance().isConnectedToInternet().then((isOnline) async {
      if (isOnline) {
        //get api response
        ApiResponse response =
            await _apiService.getAccessToken("password", username, password);

        setLoading(false);
        if (response.status == RequestStatus.SUCCESS) {
          //parse response json to dart model
          try {
            TokenResponse tokenResponse =
                TokenResponse.fromJson(jsonDecode(response.data));

            if (tokenResponse.isSuccess) {

              // save user data in preferences

              String previousUsername = _preferenceUtil.getUsername();

              if (previousUsername != username) {
                _preferenceUtil.clearAllPreferences();

                _statusDao.deleteAllStatus();
                _orderDao.deleteAllOrders();
              }

              _preferenceUtil.saveToken(tokenResponse.accessToken);
              _preferenceUtil.saveUserName(username);
              _preferenceUtil.savePassword(password);
              //pass user data to callback
              successCallback(tokenResponse.isSuccess);
            }else{
              onError("Unable to login, Please contact Administrator");
            }
          } catch (e) {
            onError(e.toString());
          }
        }else if(response.statusCode==400){
          onError("Incorrect Username or Password");
        } else {
          onError(response.message);
        }
      } else {
        setLoading(false);
        onError("No Internet Connection");
      }
    });
  }

  Rx<Event<String>> getMessage() => _msg;

  RxBool isLoading() => _isLoading;

  void onError(dynamic message) {
    _msg.value = Event(message.toString());
    _msg.refresh();
  }

  void setLoading(bool value) {
    _isLoading.value = value;
    _isLoading.refresh();
  }

}
