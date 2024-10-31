import 'dart:convert';
import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';
import '../db/models/work_status/work_status.dart';
import '../model/configuration/configurations_model.dart';

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
  static const String _requestCounter = "requestCounter";
  static const String _distributionId = "distributionId";
  static const String _organizationId = "organizationId";
  static const String _warehouseId = "warehouseId";
  static const String _hideCustomerInfo = "hideCustomerInfo";
  static const String _targetAchievement = "targetAchievement";
  static const String _punchOrderInUnits = "punchOrderInUnits";
  static const String _marketReturnButton = "marketReturnButton";
  static const String _deliveryDate = "deliveryDate";
  static const String _assetScanned = "asset_scanned";
  static const String _assetScannedInLastMonth = "assetScannedInLastMonth";
  static const String _enForcedAssetScan = "enForcedAssetScan";
  static const String _assetVerifiedCount = "assetVerifiedCount";
  static const String _assetScannedWithoutVerified = "assetScannedWithoutVerified";

  PreferenceUtil._(this._sharedPreferences);

  static PreferenceUtil getInstanceSync(SharedPreferences sharedPreferences) {
    if (_instance == null) {
      return _instance = PreferenceUtil._(sharedPreferences);
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

  WorkStatus getWorkSyncData() {
    final statusStr = _sharedPreferences.getString(_keySyncData) ?? "";

    if (statusStr.isEmpty) {
      return WorkStatus(0);
    }

    // Parse string to work status object and return
    WorkStatus workStatus = WorkStatus.fromJson(jsonDecode(statusStr));
    return workStatus;
  }

  void saveWorkSyncData(WorkStatus status) {
    String statusStr = jsonEncode(status);

    _sharedPreferences.setString(_keySyncData, statusStr);
  }

  void saveConfig(ConfigurationModel? config) {
    var configStr = "";
    if (config != null) {
      configStr = jsonEncode(config);
    }
    _sharedPreferences.setString(_keyConfig, configStr);
  }

  ConfigurationModel getConfig() {
    final configStr = _sharedPreferences.getString(_keyConfig) ?? "";

    if (configStr.isEmpty) {
      return ConfigurationModel();
    }

    // Parse string to configuration string to configuration object
    ConfigurationModel config = ConfigurationModel.fromJson(jsonDecode(configStr));
    return config;
  }

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
    // return true;
    return getUsername().startsWith("u_");
  }

  void setOutletStatus(int value) {
    _sharedPreferences.setInt(_outletStatus, value);
  }

  int getOutletStatus() {
    return _sharedPreferences.getInt(_outletStatus) ?? 1;
  }

  void setRequestCounter(int value) {
    _sharedPreferences.setInt(_requestCounter, value);
  }

  int getRequestCounter() {
    return _sharedPreferences.getInt(_requestCounter) ?? 1;
  }

  void saveDistributionId(int distributionId) {
    _sharedPreferences.setInt(_distributionId, distributionId);
  }

  int getDistributionId() {
    return _sharedPreferences.getInt(_distributionId) ?? 1;
  }

  void saveOrganizationId(int organizationId) {
    _sharedPreferences.setInt(_organizationId,organizationId);
  }

  int getOrganizationId() {
    return _sharedPreferences.getInt(_organizationId) ?? 1;
  }

  void saveWarehouseId(int warehouseId) {
    _sharedPreferences.setInt(_organizationId,warehouseId);
  }

  int getWarehouseId() {
    return _sharedPreferences.getInt(_warehouseId) ?? 1;
  }

  void setHideCustomerInfo(bool? hideCustomerInfoInOrderingApp) {
    _sharedPreferences.setBool(_hideCustomerInfo, hideCustomerInfoInOrderingApp??false);
  }

  bool getHideCustomerInfo() {
    return _sharedPreferences.getBool(_hideCustomerInfo)??false;
  }

  void setPunchOrderInUnits(bool? canNotPunchOrderInUnits) {
    _sharedPreferences.setBool(_punchOrderInUnits, canNotPunchOrderInUnits??false);
  }

  bool getPunchOrderInUnits() {
   return _sharedPreferences.getBool(_punchOrderInUnits)??false;
  }

  void setTargetAchievement(String? targetAchievement) {
    if(targetAchievement!=null){
      _sharedPreferences.setString(_targetAchievement, targetAchievement);
    }

  }

  String? getTargetAchievement() {
    return _sharedPreferences.getString(_targetAchievement);
  }

  void setShowMarketReturnsButton(bool? showMarketReturnButton) {
    _sharedPreferences.setBool(_marketReturnButton,showMarketReturnButton??false);
  }

  bool getShowMarketReturnsButton() {
    return _sharedPreferences.getBool(_marketReturnButton)??true;
  }

  void setDeliveryDate(int deliveryDate) {
    _sharedPreferences.setInt(_deliveryDate, deliveryDate);
  }

  int getDeliveryDate()=>_sharedPreferences.getInt(_deliveryDate)??0;

  void setAssetScanned(bool scanned) {
    _sharedPreferences.setBool(_assetScanned, scanned);
  }
  bool getAssetScanned() {
    return _sharedPreferences.getBool(_assetScanned)??false;
  }

  void setAssetScannedInLastMonth(bool value) {
    _sharedPreferences.setBool(_assetScanned, value);
  }

  bool getAssetScannedInLastMonth() {
    return _sharedPreferences.getBool(_assetScannedInLastMonth)??false;
  }

  bool getEnforcedAssetScan() {
    return _sharedPreferences.getBool(_enForcedAssetScan)??false;
  }

  void setEnforcedAssetScan(bool value) {
    _sharedPreferences.setBool(_enForcedAssetScan,value);
  }

  int getAssetsVerifiedCount() {
    return _sharedPreferences.getInt(_assetVerifiedCount)??0;
  }

  void setAssetsVerifiedCount(int count) {
    _sharedPreferences.setInt(_assetVerifiedCount, count);
  }

  void setAssetsScannedWithoutVerified(bool value) {
    _sharedPreferences.setBool(_assetScannedWithoutVerified, value);
  }

  bool getAssetsScannedWithoutVerified() {
    return _sharedPreferences.getBool(_assetScannedWithoutVerified)??false;
  }

}
