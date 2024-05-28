
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtil {
  static PreferenceUtil? _instance;

  final SharedPreferences _sharedPreferences;
  static const String _keyToken = "token";
  static const String _keyUsername = "username";
  static const String _keyPassword = "password";
  static const String _keySyncData = "sync_date";
  static const String _keyConfig = "config";
  static const String _targetOutletsMV = "target_outlets_mv";
  static const String _targetOutletsWW = "target_outlets_ww";
  static const String _outletStatus = "outlet_status";


  PreferenceUtil._(this._sharedPreferences);

  static PreferenceUtil getInstanceSync(SharedPreferences sharedPreferences){
    if (_instance == null) {
      return _instance =
          PreferenceUtil._(sharedPreferences);
    } else {
      return _instance!;
    }
  }

  static Future<PreferenceUtil> getInstance() async {
    if (_instance == null) {
      return _instance =
          PreferenceUtil._(await SharedPreferences.getInstance());
    } else {
      return _instance!;
    }
  }

  void clearAllPreferences() {
    _sharedPreferences.clear();
    _sharedPreferences.commit();
  }

  void saveToken(String? token) {
    if (token != null) {
      _sharedPreferences.setString(_keyToken, token);
    }
  }

  String getToken() {
    return _sharedPreferences.getString(_keyToken) ?? "";
  }

  void saveUserName(String? username) {
    if (username != null) {
      _sharedPreferences.setString(_keyUsername, username);
    }
  }

  String getUsername() {
    // return "u_1018@hbl.com";
    return _sharedPreferences.getString(_keyUsername) ?? "";
  }

  void savePassword(String? password) {
    if (password != null) {
      _sharedPreferences.setString(_keyPassword, password);
    }
  }

  String getPassword() {
    // return "Pass@word1";
    return _sharedPreferences.getString(_keyPassword) ?? "";
  }
  //
  // WorkStatus getWorkSyncData() {
  //   final statusStr = _sharedPreferences.getString(_keySyncData) ?? "";
  //
  //   if (statusStr.isEmpty) {
  //     return WorkStatus(0);
  //   }
  //
  //   // Parse string to work status object and return
  //   WorkStatus workStatus = WorkStatus.fromJson(jsonDecode(statusStr));
  //   return workStatus;
  // }
  //
  // void saveWorkSyncData(WorkStatus status) {
  //   String statusStr = jsonEncode(status);
  //
  //   _sharedPreferences.setString(_keySyncData, statusStr);
  // }
  //
  // void saveConfig(Configuration? config) {
  //   var configStr = "";
  //   if (config != null) {
  //     configStr = jsonEncode(config);
  //   }
  //   _sharedPreferences.setString(_keyConfig, configStr);
  // }
  //
  // Configuration getConfig() {
  //   final configStr = _sharedPreferences.getString(_keyConfig) ?? "";
  //
  //   if (configStr.isEmpty) {
  //     return Configuration();
  //   }
  //
  //   // Parse string to configuration string to configuration object
  //   Configuration config = Configuration.fromJson(jsonDecode(configStr));
  //   return config;
  // }

  void setMVTargetOutlets(int? value) {
    if (value != null) {
      _sharedPreferences.setInt(_targetOutletsMV, value);
    }
  }

  int getMVTargetOutlets() {
    return _sharedPreferences.getInt(_targetOutletsMV) ?? 0;
  }

  void setWWTargetOutlets(int? value) {
    if (value != null) {
      _sharedPreferences.setInt(_targetOutletsWW, value);
    }
  }

  int getWWTargetOutlets() {
    return _sharedPreferences.getInt(_targetOutletsWW) ?? 0;
  }

  bool isTestUser() {
    // return false;
    return getUsername().startsWith("u_");
  }

  void setOutletStatus(int value) {
    _sharedPreferences.setInt(_outletStatus, value);
  }

  int getOutletStatus() {
    return _sharedPreferences.getInt(_outletStatus) ?? 1;
  }

}
