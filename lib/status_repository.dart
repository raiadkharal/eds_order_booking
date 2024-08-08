import 'package:order_booking/db/entities/asset/asset.dart';
import 'package:order_booking/db/entities/lookup/lookup.dart';
import 'package:order_booking/db/entities/outlet/outlet.dart';
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
  final PreferenceUtil _preferenceUtil;

  StatusRepository(this._routeDao, this._orderStatusDao, this._merchandiseDao, this._preferenceUtil);

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

}
