import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../components/progress_dialog/PregressDialog.dart';

void showToastMessage(String message) {
  toastification.show(
    title: Text(message),
    style: ToastificationStyle.simple,
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 2),
  );
}

void showProgressDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const SimpleProgressDialog();
      });
}

showProgressDial(BuildContext context) {
  //set up the AlertDialog
  AlertDialog alert = const AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
      child: CircularProgressIndicator(),
    ),
  );
  showDialog(
    //prevent outside touch
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      //prevent Back button press
      return PopScope(canPop: false, child: alert);
    },
  );
}

bool boolFromInt(int? intValue) => intValue == 1;

int boolToInt(bool? boolValue) => boolValue == true ? 1 : 0;

String? keyToExcludeToJson(String? keyToExclude) {
  return keyToExclude;
}
