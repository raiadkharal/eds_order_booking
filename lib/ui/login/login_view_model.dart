import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../utils/PreferenceUtil.dart';
import '../../utils/enums.dart';
import '../../utils/event.dart';
import 'login_repository.dart';

class LoginViewModel extends GetxController {
  final LoginRepository _repository;
  final PreferenceUtil _preferenceUtil;
  RxBool isLoggedIn = false.obs;

  LoginViewModel(this._repository, this._preferenceUtil);

  void login(String username, String password,
      Function(bool success) successCallback) {
    _repository.login(
      username,
      password,
    successCallback
    /*  (response) {
        setLoading(false);
        if (response.status == RequestStatus.SUCCESS) {
          LoggedInUser user = response.data;
          // _repository.setLoggedInUser(user);
          successCallback(true);
        } else {
          Fluttertoast.showToast(msg: response.message.toString());
        }
      },*/
    );
  }

  // @override
  // void onInit() {
  //   ever(isLoggedIn, fireRoute);
  //   isLoggedIn.value = _preferenceUtil.getToken().isNotEmpty;
  // }
  //
  // fireRoute(logged) {
  //   if (logged) {
  //     Get.off(const HomeScreen());
  //   } else {
  //     Get.off(LoginScreen());
  //   }
  // }

  bool isUserAlreadyLoggedIn() {
    // return false;
    return _preferenceUtil.getToken().isNotEmpty;
  }

  Rx<Event<String>> getMessage()=>_repository.getMessage();

  RxBool isLoading()=>_repository.isLoading();


  void setLoading(bool value) {
    _repository.setLoading(value);
  }
}
