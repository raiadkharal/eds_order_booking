import 'package:order_booking/db/entities/asset/asset.dart';
import 'package:order_booking/db/entities/lookup/lookup.dart';
import 'package:order_booking/db/entities/promotion/promotion.dart';
import 'package:order_booking/db/entities/route/route.dart';

import '../entities/outlet/outlet.dart';
import '../models/outlet_order_status/outlet_order_status.dart';

abstract class RouteDao {

  Stream<List<Outlet>> getOutletStream();

  Future<void> deleteAllMerchandise();

  Future<void> deleteAllPromotion();

  Future<void> deleteAllLookUp();

  Future<void> deleteAllRoutes();

  Future<void> deleteAllAssets();

  Future<void> deleteAllOutlets();

  Future<void> insertRoutes(List<MRoute> routeList);

  Future<void> insertOutlets(List<Outlet> outletList);

  Future<void> updateOutlet(Outlet outlet);

  Future<void> insertAssets(List<Asset>? assetList);

  Future<void> insertPromotion(List<Promotion>? promosAndFOC);

  Future<void> insertLookUp(LookUp? lookUp);

  Future<List<Outlet>> getPendingOutlets();

  Future<List<Outlet>> getVisitedOutlets();

  Future<List<Outlet>> getProductiveOutlets();

  Future<List<Outlet>> getUnplannedOutlets(int routeId);

  Future<List<Outlet>> getAllOutletsForRoute(int routeId);

  Future<Outlet> getOutletById(int outletId);

  Future<List<Promotion>> getPromotionByOutletId(int outletId);
}
