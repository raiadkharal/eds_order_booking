import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:order_booking/db/entities/asset/asset.dart';
import 'package:order_booking/db/entities/lookup/lookup.dart';
import 'package:order_booking/db/entities/order_status/order_status.dart';
import 'package:order_booking/db/entities/promotion/promotion.dart';
import 'package:order_booking/db/entities/route/route.dart';

import '../../model/outlet_model/outlet_model.dart';
import '../entities/available_stock/available_stock.dart';
import '../entities/outlet/outlet.dart';
import '../models/outlet_order_status/outlet_order_status.dart';

abstract class RouteDao {

  Stream<List<OutletOrderStatus>> getOutletStream();

  Future<void> deleteAllMerchandise();

  Future<void> deleteAllPromotion();

  Future<void> deleteAllLookUp();

  Future<void> deleteAllRoutes();

  Future<void> deleteAllAssets();

  Future<void> deleteAllOutlets();

  Future<void> insertRoutes(List<MRoute> routeList);

  Future<void> insertOutlets(List<Outlet> outletList);

  Future<void> updateOutlet(Outlet? outlet);

  Future<void> insertAssets(List<Asset> assetList);

  Future<void> insertPromotion(List<Promotion> promosAndFOC);

  Future<void> insertLookUp(LookUp? lookUp);

  Future<List<OutletOrderStatus>> getPendingOutlets();

  Future<List<OutletOrderStatus>> getVisitedOutlets();

  Future<List<OutletOrderStatus>> getProductiveOutlets();

  Future<List<OutletOrderStatus>> getUnplannedOutlets(int routeId);

  Future<List<OutletOrderStatus>> getAllOutletsForRoute(int routeId);

  Future<Outlet> getOutletById(int outletId);

  Future<List<Promotion>> getPromotionByOutletId(int outletId);

  Future<int?> getSalesManId();

  Future<void> updateOutletVisitStatus(int? outletId, int visitStatus, bool synced);

  Future<void> updateOutletStatus(int statusId, int outletId);

  Future<LookUp?> getLookUpData();

  Future<void> updateOutletCnic(int? outletId, String? mobileNumber, String? cnic, String? strn);

  Future<List<OrderStatus>> findPendingOrderToSync(bool synced);

  Future<List<Outlet>> findAllOutlets();

  Future<List<Outlet>> findOutletsWithPendingTasks();

  Future<List<MRoute>> findAllRoutes();

  Future<int> getPjpCount();

  Future<int> getCompletedCount();

  Future<int> getProductiveCount();

  Future<int> getPendingCount();

  Future<List<OrderStatus>> findPendingOrderToSyncEx();

  Future<void> deleteOrderAndAvailableTempQty();

  Future<void> updateAvailableStockInOutlet(List<OutletModel>? outletList,List<AvailableStock>? availableStock);
}
