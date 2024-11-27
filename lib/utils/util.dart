import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:order_booking/db/entities/unit_price_breakdown/unit_price_breakdown.dart';
import 'package:toastification/toastification.dart';

class Util {
  static const String DATE_FORMAT_1 = "MM/dd/yy";
  static const String DATE_FORMAT_2 = "MMM dd";
  static const String DATE_FORMAT_3 = "MMM-dd";
  static const String DATE_FORMAT ="MMM dd yyyy";
  static const String DATE_FORMAT_5 = "hh:mm a";
  static const String DATE_FORMAT_4 = "MM/dd/yyyy hh:mm a";
  static const String DATE_FORMAT_6 = "yyyy-MM-dd'T'HH:mm:ss.SSS";

  static Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  static bool isDateToday(int timestamp) {
    // Convert timestamp to DateTime
    DateTime dateTimeFromTimestamp =
        DateTime.fromMillisecondsSinceEpoch(timestamp);

    // Get current date
    DateTime currentDate = DateTime.now();

    // Check if the date from the timestamp is the same as the current date
    return isSameDate(dateTimeFromTimestamp, currentDate);
  }

  static String formatDate(String format, int? dateInMilli) {
    if (dateInMilli == null) {
      return "";
    }
    try {
      // Convert timestamp to DateTime
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dateInMilli);

      // Format the date to given format
      String formattedDate = DateFormat(format).format(dateTime);
      return formattedDate;
    } catch (e) {
      return "";
    }
  }

  // Future<String> imageFileToBase64(File imageFile) async {
  //   List<int> imageBytes = await imageFile.readAsBytes();
  //   String base64Image = base64Encode(imageBytes);
  //   return base64Image;
  // }

  static Future<String?> imageFileToBase64(String filePath) async {
    try {
      File imageFile = File(filePath);
      List<int> imageBytes = await imageFile.readAsBytes();
      final base64String = base64Encode(imageBytes);
      return utf8.decode(base64String.codeUnits);
    } catch (e) {
      showToastMessage("Something went wrong. Please try again later");
    }
    return null;
  }

  static Future<String> convertImageToUtf8(String imagePath) async {
    final file = File(imagePath);
    final bytes = await file.readAsBytes();
    final base64String = base64Encode(bytes);
    final utf8String = utf8.decode(base64String.codeUnits);
    return utf8String;
  }

  static bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static void showToastMessage(String message) {
    toastification.show(
      title: Text(message),
      style: ToastificationStyle.simple,
      alignment: Alignment.bottomCenter,
      autoCloseDuration: const Duration(seconds: 2),
    );
  }

  static double checkMetre(LatLng? from, LatLng? to) {
    if (from != null && to != null) {
      double distance = Geolocator.distanceBetween(
          from.latitude, from.longitude, to.latitude, to.longitude);
      //ensure only 2 decimal digits
      return double.parse(distance.toStringAsFixed(2));
    } else {
      return 0.0;
    }
  }

  static String formattedDistance(double distance) {
    double distanceInKm = distance / 1000;
    return "${distanceInKm.toStringAsFixed(2)} km";
  }

 static bool isCurrentDateMatched(int? startDate) {

    if(startDate==null){
      return false;
    }
    DateTime startDateTime = DateTime.fromMillisecondsSinceEpoch(startDate);
    DateTime currentDate = DateTime.now();

    if (startDateTime.day != currentDate.day) {
      return false;
    } else {
      return true;
    }
  }



  static String convertStockToDecimalQuantity(int? carton, int? units) {
    carton ??= 0;
    units ??= 0;

    String finalVal = "0.0";
    if (carton > 0 && units > 0) {
      finalVal = "$carton.$units";
    } else if (carton > 0) {
      finalVal = "$carton";
    } else if (units > 0) {
      finalVal = "0.$units";
    }

    return finalVal;
  }

  static String? convertStockToNullableDecimalQuantity(int? carton, int? units) {

    if(carton==null&&units==null) return null;

    carton ??= 0;
    units ??= 0;

    String? finalVal;
    if (carton > 0 && units > 0) {
      finalVal = "$carton.$units";
    } else if (carton > 0) {
      finalVal = "$carton";
    } else if (units > 0) {
      finalVal = "0.$units";
    }

    return finalVal;
  }

  static List<int>? convertToLongQuantity(String qty) {

    if(qty==""){
      return null;
    }

    if (qty.startsWith(".")) {
      qty = "0$qty";
    }
    int decimal;
    int fractional;

    bool isWhole = Util.isInt(double.parse(qty));
    if (isWhole) {
      decimal = int.parse(qty.split(".")[0]);
      fractional = 0;
    } else {
      decimal = int.parse(qty.split(".")[0]);
      fractional = int.parse(qty.split(".")[1]);
    }
    return [decimal, fractional];
  }

  static bool isInt(double d) {
    return d == d.toInt();
  }

  static int convertToUnits(int? carton, int? cartonSize, int? units) {
    carton ??= 0;
    units ??= 0;

    int finalVal = 0;
    if (carton < 1) {
      finalVal = units;
    } else {
      int totalUnits = carton * (cartonSize ?? 60);
      finalVal = totalUnits + units;
    }

    return finalVal;
  }

  static String formatCurrency(double? price, int fractionDigits) {
    price ??= 0;

    final format = NumberFormat.currency(
      locale: 'en_PK',
      symbol: '',
      decimalDigits: fractionDigits,
    );

    final formattedPrice = format.format(price);

    // Add currency symbol separately to handle positive/negative formatting
    // final currencySymbol = NumberFormat.simpleCurrency(locale: Platform.localeName).currencySymbol;
    const currencySymbol = "Rs";
    if (price < 0) {
      return '-$currencySymbol${formattedPrice.substring(1)}';  // Remove minus sign from formatted price
    } else {
      return '$currencySymbol $formattedPrice';
    }
  }

  static bool isListEmpty(List<dynamic>? list) {
    return(list==null||list.isEmpty);
  }


  static Map<String, dynamic> removeNulls(Map<String, dynamic> original) {
    final result = <String, dynamic>{};

    original.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        // Recursively process nested maps
        final nestedMap = removeNulls(value);
        if (nestedMap.isNotEmpty) {
          result[key] = nestedMap;
        }
      } else if (value is List) {
        // Recursively process lists
        final nestedList = value
            .map((element) =>
        element is Map<String, dynamic> ? removeNulls(element) : element)
            .where((element) => element != null)
            .toList();

        if (nestedList.isNotEmpty) {
          result[key] = nestedList;
        }
      } else if (value != null) {
          result[key] = value;
      }
    });

    return result;
  }

}
