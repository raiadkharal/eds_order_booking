 import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:order_booking/db/entities/merchandise/merchandise.dart';
import 'package:order_booking/db/entities/task/task.dart';
import 'package:order_booking/model/configuration/configurations_model.dart';
import 'package:order_booking/model/upload_message_model/upload_message_model.dart';
import 'package:order_booking/utils/PreferenceUtil.dart';

import '../db/dao/merchandise_dao.dart';
import '../db/dao/pricing_dao.dart';
import '../db/dao/task_dao.dart';

class Repository {
 final PreferenceUtil _preferenceUtil;
 final MerchandiseDao _merchandiseDao;
 final TaskDao _taskDao;
 final PricingDao _pricingDao;

 Repository(this._preferenceUtil, this._merchandiseDao, this._taskDao, this._pricingDao);

 Future<void> insertIntoDB(Merchandise merchandise) =>
     _merchandiseDao.insertMerchandise(merchandise);

 ConfigurationModel getConfiguration() => _preferenceUtil.getConfig();

  Future<List<Task>?> getTasksByOutlet(int outletId)=>_taskDao.getTaskByOutletId(outletId);

 Future<int> priceConditionClassValidation() {
  return _pricingDao.priceConditionClassValidation();
 }

 Future<int> priceConditionValidation() {
  return _pricingDao.priceConditionValidation();
 }

 Future<int> priceConditionTypeValidation() {
  return _pricingDao.priceConditionTypeValidation();
 }

  void setAssetsScannedInLastMonth(bool value) {
  _preferenceUtil.setAssetScannedInLastMonth(value);
  }

  Future<Merchandise?> findMerchandise(int outletId) {
  return _merchandiseDao.findMerchandiseByOutletId(outletId);
  }

  void setEnforcedAssetScan(bool value) {
  _preferenceUtil.setEnforcedAssetScan(value);
  }

 bool getEnforceAssetScan() {
  return _preferenceUtil.getEnforcedAssetScan();
 }

  bool getAssetsScanned() {
  return _preferenceUtil.getAssetScanned();
  }

  bool isTestUser() {
  return _preferenceUtil.isTestUser();
  }

  int getAssetsVerifiedCount() {
  return _preferenceUtil.getAssetsVerifiedCount();
  }

}