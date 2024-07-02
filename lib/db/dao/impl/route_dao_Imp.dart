import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:order_booking/db/dao/route_dao.dart';
import 'package:order_booking/db/entities/asset/asset.dart';
import 'package:order_booking/db/entities/lookup/lookup.dart';
import 'package:order_booking/db/entities/promotion/promotion.dart';
import 'package:order_booking/db/entities/route/route.dart';
import 'package:order_booking/db/models/outlet_order_status/outlet_order_status.dart';
import 'package:sqflite/sqflite.dart';

import '../../entities/outlet/outlet.dart';

class RouteDaoImp extends RouteDao {
  final Database _database;

  final _outletController = StreamController<List<Outlet>>.broadcast();

  RouteDaoImp(this._database);

  @override
  Stream<List<Outlet>> getOutletStream() {
    return _outletController.stream;
  }

  void refreshOutlets(int? routeId) async {
    if (routeId != null) {
      final outlets = await getAllOutletsForRoute(routeId);
      _outletController.sink.add(outlets);
    }
  }

  @override
  Future<void> deleteAllAssets() async {
    _database.rawQuery("DELETE FROM Asset");
  }

  @override
  Future<void> deleteAllLookUp() async {
    _database.rawQuery("DELETE FROM LookUp");
  }

  @override
  Future<void> deleteAllMerchandise() async {
    _database.rawQuery("DELETE FROM Merchandise");
  }

  @override
  Future<void> deleteAllOutlets() async {
    _database.rawQuery("DELETE FROM Outlet");
  }

  @override
  Future<void> deleteAllPromotion() async {
    _database.rawQuery("DELETE FROM Promotions");
  }

  @override
  Future<void> deleteAllRoutes() async {
    _database.rawQuery("DELETE FROM Route");
  }

  @override
  Future<void> insertRoutes(List<MRoute> routeList) async {
    for (MRoute route in routeList) {
      _database.insert("Route", route.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<void> insertOutlets(List<Outlet> outletList) async {
    try {
      for (Outlet outlet in outletList) {
        _database.insert("Outlet", outlet.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> updateOutlet(Outlet outlet) async {
    _database.update("Outlet", outlet.toJson(),
        where: "outletId = ?", whereArgs: [outlet.outletId]);

    refreshOutlets(outlet.routeId);
  }

  void dispose() {
    _outletController.close();
  }

  @override
  Future<void> insertAssets(List<Asset>? assetList) async {
    if (assetList != null) {
      for (Asset asset in assetList) {
        _database.insert("Asset", asset.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertPromotion(List<Promotion>? promosAndFOC) async {
    if (promosAndFOC != null) {
      for (Promotion promotion in promosAndFOC) {
        _database.insert("Promotions", promotion.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertLookUp(LookUp? lookUp) async {
    if (lookUp != null) {
      _database.insert("LookUp", lookUp.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<List<Outlet>> getPendingOutlets() async {
    // final result = await _database.rawQuery(
    //     "SELECT Outlet.*, OrderStatus.* FROM Outlet LEFT JOIN OrderStatus ON Outlet.outletId = OrderStatus.outletId" +
    //         " WHERE  Outlet.planned=1 AND  ( ( OrderStatus.status < 2) OR ( Outlet.statusId < 2 ) ) ");

    final result = await _database.rawQuery(
        "SELECT Outlet.* FROM Outlet LEFT JOIN OrderStatus ON Outlet.outletId = OrderStatus.outletId" +
            " WHERE  Outlet.planned=1 AND  ( ( OrderStatus.status < 2) OR ( Outlet.statusId < 2 ) ) ");

    return result
        .map(
          (e) => Outlet.fromJson(e),
        )
        .toList();
  }

  @override
  Future<List<Outlet>> getProductiveOutlets() async {
    final result = await _database.rawQuery(
        "SELECT Outlet.* FROM Outlet LEFT JOIN OrderStatus ON Outlet.outletId = OrderStatus.outletId" +
            " WHERE  Outlet.planned=1 AND  ((OrderStatus.status >=8) OR (Outlet.statusId >=8)) ");

    return result
        .map(
          (e) => Outlet.fromJson(e),
        )
        .toList();
  }

  @override
  Future<List<Outlet>> getVisitedOutlets() async {
    final result = await _database.rawQuery(
        "SELECT Outlet.* FROM Outlet LEFT JOIN OrderStatus ON Outlet.outletId = OrderStatus.outletId" +
            " WHERE  Outlet.planned=1 AND  ( (OrderStatus.status between 2 AND 7) OR (Outlet.statusId between 2 AND 7))");

    return result
        .map(
          (e) => Outlet.fromJson(e),
        )
        .toList();
  }

  @override
  Future<List<Outlet>> getUnplannedOutlets(int routeId) async {
    final result = await _database.rawQuery(
        "SELECT * FROM Outlet WHERE planned=0 ORDER BY sequenceNumber");

    return result
        .map(
          (e) => Outlet.fromJson(e),
        )
        .toList();
  }

  @override
  Future<List<Outlet>> getAllOutletsForRoute(int routeId) async {
    final result = await _database
        .rawQuery("SELECT * FROM Outlet ORDER BY sequenceNumber");

    return result
        .map(
          (e) => Outlet.fromJson(e),
        )
        .toList();
  }

  @override
  Future<Outlet> getOutletById(int outletId) async {
    final result = await _database
        .query("Outlet", where: "outletId = ?", whereArgs: [outletId]);

    return Outlet.fromJson(result.first);
  }

  @override
  Future<List<Promotion>> getPromotionByOutletId(int outletId) async {
    final result = await _database
        .query("Promotions", where: "outletId = ?", whereArgs: [outletId]);

    return result
        .map(
          (e) => Promotion.fromJson(e),
        )
        .toList();
  }
}
