import 'package:flutter/cupertino.dart';

class Constants {
  //Engro testing url
  static const baseUrl = "http://101.50.85.136:84/api/api/";

/*  //Engro testing url
  static const baseUrl = "http://101.50.85.136:83/api/";*/

  /* //Engro testing url
  static const baseUrl = "http://101.50.85.136:85/api/api/";*/

/*//pepsi testing url
  static const baseUrl = "http://101.50.85.136:81/api/";*/

/*// pepsi production
  static const baseUrl = "https://edshblapi.azurewebsites.net/";*/

  static const String NETWORK_ERROR = "No internet, Please try again later!";

  static const String GENERIC_ERROR =
      "Something went wrong, Please contact Manager!";
  static const String GENERIC_ERROR2 =
      "Something went wrong, Please try again!";
  static const String LOADED = "Loaded Successfully!";
  static String ERROR_DAY_NO_STARTED = "You have not even started your day";
  static String PRICING_ERROR = "Something went wrong, Please try again!";
  static String PRICING_CASHMEMO_ERROR =
      "System is not able to calculate price, Please try again!";
  static const String PHONE_NUMBER_HELPER_TEXT = "923XXXXXXXXX";

  static const int MERCHANDISE_BEFORE_IMAGE = 0;
  static const int MERCHANDISE_AFTER_IMAGE = 1;

  static int PRIMARY = 1;
  static int SECONDARY = 2;

  static const homeButtonsPadding = 8.0;

  static const int STATUS_CONTINUE = 1;
  static const int STATUS_PENDING_TO_SYNC = 7;
  static const int STATUS_COMPLETED = 8;
  static const int STATUS_NO_ORDER_FROM_BOOKING = 6;

  static const String EXTRA_PARAM_OUTLET_REASON_N_ORDER =
      "param_outlet_reason_no_order";
  static const String EXTRA_PARAM_NO_ORDER_FROM_BOOKING = "no_order";
  static const String EXTRA_PARAM_OUTLET_ID = "param_outlet_id";
  static const String WITHOUT_VERIFICATION = "without_verification";
  static const String EXTRA_PARAM_TOKEN = "token";
  static const String EXTRA_PARAM_STATUS_ID = "status_id";

  static const String no_order_reason = "Choose reason for No Order";
  static final assetVerificationList = [
    "",
    "Scanning Not being done",
    "No Asset",
    "No Barcode"
  ];

  static final reportTopSummaryTitles = [
    "Planned",
    "N.Productive",
    "Productive",
    "Pending",
    "Synced"
  ];

  static final reportTopSummaryTitles2 = ["Completion Rate", "Strike Rate"];
  static final reportTopSummaryTitles3 = ["AVG Sku", "Drop Size"];
  static final reportQuantityTitles = ["Carton(s)", "Total Amount"];

  static const String DEVICE_NAME = "deviceName";
  static const String DEVICE_VERSION = "deviceVersion";
  static const String IS_DEVICE_ROOTED = "isDeviceRooted";
  static const String DEVICE_IMEI_NUMBER = "deviceIMEINumber";
  static const String DEVICE_MAC_ADDRESS = "deviceMacAddress";
  static const String DEVICE_UNIQUE_ID = "deviceUniqueId";

  static final Map<int?, TextEditingController> avlStockControllers = {};
  static final Map<int?, TextEditingController> orderQtyControllers = {};

  static const String MERCHANDISE_JOB_UNIQUE_NAME = "merchandise_job";
  static const String MERCHANDISE_UPLOAD_TASK = "merchandise_upload_task";
}
