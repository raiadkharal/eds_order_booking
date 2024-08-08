
import 'dart:ffi';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:order_booking/utils/extension.dart';

class DeviceInfoUtil{

  static Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }

  static Future<String?> getDeviceName() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
       String deviceManufacturer = androidDeviceInfo.manufacturer;
       String deviceModel = androidDeviceInfo.model;

      if (deviceModel. startsWith(deviceManufacturer)){
        return deviceModel.toTitleCase();
      }


      return "${deviceManufacturer.toTitleCase} $deviceModel";
    }
    return null;
  }


  static Future<String?> getDeviceVersion() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.systemVersion; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      String release = androidDeviceInfo.version.release;
      int sdkVersion = androidDeviceInfo.version.sdkInt;

      return "Android SDK: $sdkVersion ($release)";
    }
    return null;
  }

  static Future<bool> isDeviceRooted() async{
    return await checkRootMethod1() || checkRootMethod2() || await checkRootMethod3();
  }



  static Future<bool> checkRootMethod1() async{
    var deviceInfo = DeviceInfoPlugin();
    var androidDeviceInfo = await deviceInfo.androidInfo;
    String buildTags = androidDeviceInfo.tags;
    return buildTags.contains("test-keys");
  }

 static bool checkRootMethod2() {
    try {
      final file = File('/system/app/Superuser.apk');
      return file.existsSync();
    } catch (e) {
      return false;
    }
  }

  static Future<bool> checkRootMethod3() async {
    final shell = ExecShell();
    final result = await shell.executeCommand(ShellCmd.checkSuBinary);
    return result != null;
  }

  // static String capitalize(String deviceManufacturer) {
  //   if (deviceManufacturer.isEmpty) {
  //     return deviceManufacturer;
  //   }
  //
  //   List<String> arr = deviceManufacturer.split('');
  //   bool capitalizeNext = true;
  //   String text = '';
  //
  //   for (var c in arr) {
  //     if (capitalizeNext && RegExp(r'[A-Za-z]').hasMatch(c)) {
  //       text += c.toUpperCase();
  //       capitalizeNext = false; // only capitalize the first letter after whitespace
  //     } else if (c == ' ') {
  //       capitalizeNext = true;
  //       text += c; // preserve whitespace
  //     } else {
  //       text += c;
  //     }
  //   }
  //
  //   return text;
  // }


  static Future<bool> isAutoTimeEnabled() async {
    const platform = MethodChannel('com.optimus.eds/autoTime');

    try {
      final bool isAutoTimeEnabled = await platform.invokeMethod('isAutoDateTimeEnabled');
      return isAutoTimeEnabled;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to get auto time status: '${e.message}'.");
      }
      return false;
    }
  }

  static Future<void> openDateTimeSettings() async {
    const platform = MethodChannel('com.optimus.eds/autoTime');
    try {
      await platform.invokeMethod('openDateTimeSettings');
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to open date time settings: '${e.message}'.");
      }
    }
  }

  static Future<bool> isDeveloperOptionsEnabled() async {
    const platform = MethodChannel('com.optimus.eds/autoTime');
    try {
      final bool isDeveloperOptionsEnabled = await platform.invokeMethod('isDeveloperOptionsEnabled');
      return isDeveloperOptionsEnabled;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to get developer options status: '${e.message}'.");
      }
      return false;
    }
  }

}

class ExecShell {
  Future<String?> executeCommand(ShellCmd cmd) async {
    try {
      final result = await Process.run(cmd.command[0], cmd.command.sublist(1));
      if (result.exitCode == 0) {
        return result.stdout.toString();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

enum ShellCmd {
  checkSuBinary(['/system/xbin/which', 'su']);

  final List<String> command;

  const ShellCmd(this.command);
}