import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:order_booking/db/dao/task_dao.dart';
import 'package:order_booking/db/entities/asset/asset.dart';
import 'package:order_booking/db/entities/lookup/lookup.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';
import 'package:order_booking/db/entities/task/task.dart';
import 'package:order_booking/utils/PreferenceUtil.dart';

import 'db/dao/merchandise_dao.dart';
import 'db/dao/order_status_dao.dart';
import 'db/dao/route_dao.dart';
import 'db/entities/order_status/order_status.dart';
import 'model/upload_status_model/upload_status_model.dart';

class StatusRepository {
  final RouteDao _routeDao;
  final OrderStatusDao _orderStatusDao;
  final MerchandiseDao _merchandiseDao;
  final TaskDao _taskDao;
  final PreferenceUtil _preferenceUtil;

  StatusRepository(this._routeDao, this._orderStatusDao, this._merchandiseDao, this._preferenceUtil, this._taskDao);

  Future<void> updateOutlet(Outlet? outlet) async {
    _routeDao.updateOutlet(outlet);
  }

  Future<Outlet> findOutletById(int outletId) async {
    return _routeDao.getOutletById(outletId);
  }

  Future<void> insertStatus(OrderStatus status) async {
    return _orderStatusDao.insertStatus(status);
  }

  Future<OrderStatus?> findOrderStatus(int outletId) async {
    return _orderStatusDao.findOutletOrderStatus(outletId);
  }

  Future<void> update(OrderStatus? status) async {
    _orderStatusDao.update(status);
  }

  Future<int?> getSalesmanId() {
    return _routeDao.getSalesManId();
  }

  Future<void> updateStatus(OrderStatus status) async {
    _orderStatusDao.updateStatus(
        status.status,
        status.outletId,
        status.synced,
        status.orderAmount,
        status.data,
        status.outletVisitEndTime,
        status.outletDistance,
        status.outletLatitude,
        status.outletLongitude,
        status.outletVisitStartTime);
  }

  void updateOutletVisitStatus(int? outletId, int visitStatus, bool synced) {
    _routeDao.updateOutletVisitStatus(outletId, visitStatus, synced);
  }

  void updateOutletCnic(int? outletId, String? mobileNumber, String? cnic, String? strn) {
    _routeDao.updateOutletCnic(outletId,mobileNumber,cnic,strn);
  }

  Future<List<OrderStatus>> getOrderStatus() {
    return _routeDao.findPendingOrderToSync(false);
  }

  Future<List<Outlet>> findAllOutlets(){
    return _routeDao.findAllOutlets();
  }

  Future<List<Outlet>> getOutletsWithNoVisits() {
    return _routeDao.findOutletsWithPendingTasks();
  }

  Future<int> getTotalSyncCount() {
    return _orderStatusDao.getTotalSyncCount();
  }

  Future<List<UploadStatusModel>> getAllOrders() {
   return _orderStatusDao.getAllOrders();
  }

  Future<List<OrderStatus>> getOrderStatusEx() {
    return _routeDao.findPendingOrderToSyncEx();
  }

  Future<LookUp?> getLookUpData() {
    return _routeDao.getLookUpData();
  }

  Future<List<Asset>> getAssets(int outletId) {
    return _merchandiseDao.findAllAssetsForOutlet(outletId);
  }

  void updateAssets(List<Asset> assets) {
    _merchandiseDao.updateAssets(assets);
  }

  void setAssetScanned(bool scanned) {
    _preferenceUtil.setAssetScanned(scanned);
  }

  Future<List<Task>?> getTasksByOutletId(int outletId) {
    return _taskDao.getTaskByOutletId(outletId);
  }

  void updateTask(Task taskParam) {
    _taskDao.updateTask(taskParam);
  }

  bool isTestUser() {
    return _preferenceUtil.isTestUser();
  }

  void deleteTaskByOutletId(int outletId) {
    _taskDao.deleteTasksByOutletId(outletId);
  }

  void insertTasks(List<Task> taskList) {
    _taskDao.insertTasks(taskList);
  }

}
