import 'dart:async';

import 'package:order_booking/db/dao/route_dao.dart';
import 'package:order_booking/db/entities/asset/asset.dart';
import 'package:order_booking/db/entities/lookup/lookup.dart';
import 'package:order_booking/db/entities/promotion/promotion.dart';
import 'package:order_booking/db/entities/route/route.dart';
import 'package:order_booking/db/models/outlet_order_status/outlet_order_status.dart';
import 'package:order_booking/utils/Constants.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/outlet_model/outlet_model.dart';
import '../../entities/available_stock/available_stock.dart';
import '../../entities/order_status/order_status.dart';
import '../../entities/outlet/outlet.dart';

class RouteDaoImp extends RouteDao {
  final Database _database;

  final _outletController = StreamController<List<OutletOrderStatus>>.broadcast();

  RouteDaoImp(this._database);

  @override
  Stream<List<OutletOrderStatus>> getOutletStream() {
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
    await _database.transaction(
      (txn) async {
        Batch batch = txn.batch();
        for (MRoute route in routeList) {
          batch.insert("Route", route.toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }

        await batch.commit(noResult: true);
      },
    );
  }

  @override
  Future<void> insertOutlets(List<Outlet> outletList) async {
    await _database.transaction(
      (txn) async {
        Batch batch = txn.batch();
        for (Outlet outlet in outletList) {
          batch.insert("Outlet", outlet.toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }

        await batch.commit(noResult: true);
      },
    );
  }

  @override
  Future<void> updateOutlet(Outlet? outlet) async {
    if (outlet != null) {
      _database.update("Outlet", outlet.toJson(),
          where: "outletId = ?", whereArgs: [outlet.outletId]);

      refreshOutlets(outlet.routeId);
    }
  }

  void dispose() {
    _outletController.close();
  }

  @override
  Future<void> insertAssets(List<Asset> assetList) async {
    await _database.transaction(
      (txn) async {
        Batch batch = txn.batch();
        for (Asset asset in assetList) {
          batch.insert("Asset", asset.toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
        await batch.commit(noResult: true);
      },
    );
  }

  @override
  Future<void> insertPromotion(List<Promotion> promosAndFOC) async {
    await _database.transaction(
      (txn) async {
        Batch batch = txn.batch();
        for (Promotion promotion in promosAndFOC) {
          batch.insert("Promotions", promotion.toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
        await batch.commit(noResult: true);
      },
    );
  }

  @override
  Future<void> insertLookUp(LookUp? lookUp) async {
    if (lookUp != null) {
      _database.insert("LookUp", lookUp.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<List<OutletOrderStatus>> getPendingOutlets() async {
    return await _database.transaction(
      (txn) async {
        const String outletQuery =
            "SELECT Outlet.* FROM Outlet LEFT JOIN OrderStatus ON Outlet.outletId = OrderStatus.outletId" +
                " WHERE  Outlet.planned=1 AND  ( (OrderStatus.status < 2 ) OR (Outlet.statusId < 2 ))";

        List<Map<String, dynamic>> outletQueryResult =
            await txn.rawQuery(outletQuery);
        List<Outlet> outlets = outletQueryResult
            .map(
              (e) => Outlet.fromJson(e),
            )
            .toList();

        final List<OutletOrderStatus> outletOrderStatusList = [];

        for (Outlet outlet in outlets) {
          OutletOrderStatus outletOrderStatus = OutletOrderStatus();
          outletOrderStatus.outlet = outlet;
          //find order status of that outlet
          const String orderStatusQuery =
              "SELECT * FROM OrderStatus WHERE outletId = ? and status < 2 ";

          List<Map<String, dynamic>> orderStatusQueryResult =
              await txn.rawQuery(orderStatusQuery,[outlet.outletId]);
          if (orderStatusQueryResult.isNotEmpty) {
            OrderStatus orderStatus =
                OrderStatus.fromJson(orderStatusQueryResult.first);
            outletOrderStatus.orderStatus = orderStatus;
          }

          outletOrderStatusList.add(outletOrderStatus);
        }
        return outletOrderStatusList;
      },
    );

    /*final result = await _database.rawQuery(
        "SELECT Outlet.* FROM Outlet LEFT JOIN OrderStatus ON Outlet.outletId = OrderStatus.outletId" +
            " WHERE  Outlet.planned=1 AND  ( ( OrderStatus.status < 2) OR ( Outlet.statusId < 2 ) ) ");

  */ /*  final result = await _database.rawQuery(
        "SELECT Outlet.* FROM Outlet LEFT JOIN OrderStatus ON Outlet.outletId = OrderStatus.outletId" +
            " WHERE  Outlet.planned=1 AND  ( ( OrderStatus.status < 2) OR ( Outlet.statusId < 2 ) ) ");*/ /*

    return result
        .map(
          (e) => OutletOrderStatus.fromJson(e),
        )
        .toList();*/
  }

  @override
  Future<List<OutletOrderStatus>> getProductiveOutlets() async {
    return await _database.transaction(
      (txn) async {
        const String outletQuery =
            "SELECT Outlet.* FROM Outlet LEFT JOIN OrderStatus ON Outlet.outletId = OrderStatus.outletId" +
                " WHERE  Outlet.planned=1 AND  ( (OrderStatus.status >=8 ) OR (Outlet.statusId >=8 ))";

        List<Map<String, dynamic>> outletQueryResult =
            await txn.rawQuery(outletQuery);
        List<Outlet> outlets = outletQueryResult
            .map(
              (e) => Outlet.fromJson(e),
            )
            .toList();

        final List<OutletOrderStatus> outletOrderStatusList = [];

        for (Outlet outlet in outlets) {
          OutletOrderStatus outletOrderStatus = OutletOrderStatus();
          outletOrderStatus.outlet = outlet;
          //find order status of that outlet
          const String orderStatusQuery =
              "SELECT * FROM OrderStatus WHERE outletId = ? and status >= 8 ";

          List<Map<String, dynamic>> orderStatusQueryResult =
              await txn.rawQuery(orderStatusQuery);
          if (orderStatusQueryResult.isNotEmpty) {
            OrderStatus orderStatus =
                OrderStatus.fromJson(orderStatusQueryResult.first);
            outletOrderStatus.orderStatus = orderStatus;
          }

          outletOrderStatusList.add(outletOrderStatus);
        }
        return outletOrderStatusList;
      },
    );
    /* final result = await _database.rawQuery(
        "SELECT Outlet.* FROM Outlet LEFT JOIN OrderStatus ON Outlet.outletId = OrderStatus.outletId" +
            " WHERE  Outlet.planned=1 AND  ((OrderStatus.status >=8) OR (Outlet.statusId >=8)) ");

    return result
        .map(
          (e) => Outlet.fromJson(e),
        )
        .toList();*/
  }

  @override
  Future<List<OutletOrderStatus>> getVisitedOutlets() async {
    return await _database.transaction(
      (txn) async {
        const String outletQuery =
            "SELECT Outlet.* FROM Outlet LEFT JOIN OrderStatus ON Outlet.outletId = OrderStatus.outletId" +
                " WHERE  Outlet.planned=1 AND  ( (OrderStatus.status between 2 AND 7) OR (Outlet.statusId between 2 AND 7))";

        List<Map<String, dynamic>> outletQueryResult =
            await txn.rawQuery(outletQuery);
        List<Outlet> outlets = outletQueryResult
            .map(
              (e) => Outlet.fromJson(e),
            )
            .toList();

        final List<OutletOrderStatus> outletOrderStatusList = [];

        for (Outlet outlet in outlets) {
          OutletOrderStatus outletOrderStatus = OutletOrderStatus();
          outletOrderStatus.outlet = outlet;
          //find order status of that outlet
          const String orderStatusQuery =
              "SELECT * FROM OrderStatus WHERE outletId = ? and status between 2 and 7 ";

          List<Map<String, dynamic>> orderStatusQueryResult =
              await txn.rawQuery(orderStatusQuery);
          if (orderStatusQueryResult.isNotEmpty) {
            OrderStatus orderStatus =
                OrderStatus.fromJson(orderStatusQueryResult.first);
            outletOrderStatus.orderStatus = orderStatus;
          }

          outletOrderStatusList.add(outletOrderStatus);
        }
        return outletOrderStatusList;
      },
    );

    /* final result = await _database.rawQuery(
        "SELECT Outlet.* FROM Outlet LEFT JOIN OrderStatus ON Outlet.outletId = OrderStatus.outletId" +
            " WHERE  Outlet.planned=1 AND  ( (OrderStatus.status between 2 AND 7) OR (Outlet.statusId between 2 AND 7))");

    return result
        .map(
          (e) => Outlet.fromJson(e),
        )
        .toList();*/
  }

  @override
  Future<List<OutletOrderStatus>> getUnplannedOutlets(int routeId) async {
    final result = await _database.rawQuery(
        "SELECT * FROM Outlet WHERE planned=0 ORDER BY sequenceNumber");

    final outletList = result
        .map(
          (e) => Outlet.fromJson(e),
        )
        .toList();

    final List<OutletOrderStatus> outletOrderStatusList = [];

    for (Outlet outlet in outletList) {
      OutletOrderStatus outletOrderStatus = OutletOrderStatus();
      outletOrderStatus.outlet=outlet;
      outletOrderStatus.orderStatus=null;

      outletOrderStatusList.add(outletOrderStatus);
    }

    return outletOrderStatusList;
  }

  @override
  Future<List<OutletOrderStatus>> getAllOutletsForRoute(int routeId) async {

    return await _database.transaction(
          (txn) async {
        const String outletQuery =
            "SELECT * FROM Outlet ORDER BY sequenceNumber";

        List<Map<String, dynamic>> outletQueryResult =
        await txn.rawQuery(outletQuery);
        List<Outlet> outlets = outletQueryResult
            .map(
              (e) => Outlet.fromJson(e),
        )
            .toList();

        final List<OutletOrderStatus> outletOrderStatusList = [];

        for (Outlet outlet in outlets) {
          OutletOrderStatus outletOrderStatus = OutletOrderStatus();
          outletOrderStatus.outlet = outlet;
          //find order status of that outlet
          const String orderStatusQuery =
              "SELECT * FROM OrderStatus where outletId = ?";

          List<Map<String, dynamic>> orderStatusQueryResult =
          await txn.rawQuery(orderStatusQuery,[outlet.outletId]);
          if (orderStatusQueryResult.isNotEmpty) {
            OrderStatus orderStatus =
            OrderStatus.fromJson(orderStatusQueryResult.first);
            outletOrderStatus.orderStatus = orderStatus;
          }

          outletOrderStatusList.add(outletOrderStatus);
        }
        return outletOrderStatusList;
      },
    );

    /*final result = await _database
        .rawQuery("SELECT * FROM Outlet ORDER BY sequenceNumber");

    return result
        .map(
          (e) => Outlet.fromJson(e),
        )
        .toList();*/
  }

  @override
  Future<Outlet> getOutletById(int outletId) async {
    final result = await _database
        .query("Outlet", where: "outletId = ?", whereArgs: [outletId]);

    if (result.isNotEmpty) {
      return Outlet.fromJson(result.first);
    }

    return Outlet();
  }

  @override
  Future<List<Promotion>> getPromotionByOutletId(int outletId) async {
    final result = await _database
        .query("Promotions", where: "outletId = ?", whereArgs: [outletId]);

    if(result.isNotEmpty) {
      return result
          .map(
            (e) => Promotion.fromJson(e),
      )
          .toList();
    }

    return [];
  }

  @override
  Future<int?> getSalesManId() async {
    final result = await _database.rawQuery("SELECT employeeId FROM Route");

    if (result.isNotEmpty) {
      return result.first['employeeId'] as int;
    }

    return null;
  }

  @override
  Future<void> updateOutletVisitStatus(
      int? outletId, int visitStatus, bool synced) async {
    if (outletId != null) {
      _database.rawUpdate(
          "Update Outlet SET visitStatus= ?, synced= ? where outletId= ?",
          [visitStatus, synced, outletId]);
    }
  }

  @override
  Future<void> updateOutletStatus(int statusId, int outletId) async {
    _database.rawUpdate("Update Outlet set statusId = ? WHERE outletId = ?",
        [statusId, outletId]);
  }

  @override
  Future<LookUp?> getLookUpData() async {
    final result = await _database.rawQuery("SELECT * FROM LookUp");

    if (result.isNotEmpty) {
      return LookUp.fromJson(result.first);
    }

    return null;
  }

  @override
  Future<void> updateOutletCnic(
      int? outletId, String? mobileNumber, String? cnic, String? strn) async {
    if (outletId != null) {
      _database.rawUpdate(
          "Update Outlet SET mobileNumber=?, cnic= ?, strn= ? where outletId= ?",
          [mobileNumber, cnic, strn, outletId]);
    }
  }

  @override
  Future<List<OrderStatus>> findPendingOrderToSync(bool synced) async {
    final result = await _database.rawQuery(
        "SELECT * FROM OrderStatus WHERE sync= ? AND status between 2 AND 7 ",
        [synced]);

    return result
        .map(
          (e) => OrderStatus.fromJson(e),
        )
        .toList();
  }

  @override
  Future<List<Outlet>> findAllOutlets() async {
    final result = await _database
        .rawQuery("SELECT * FROM Outlet ORDER BY outletName ASC");

    return result
        .map(
          (e) => Outlet.fromJson(e),
        )
        .toList();
  }

  @override
  Future<List<Outlet>> findOutletsWithPendingTasks() async {
    final result = await _database.rawQuery(
        "SELECT Outlet.*, OrderStatus.* FROM Outlet LEFT JOIN OrderStatus ON Outlet.outletId = OrderStatus.outletId" +
            " WHERE  Outlet.planned=1 AND  ( ( OrderStatus.status < 2) OR ( Outlet.statusId < 2 ) )");

    return result
        .map(
          (e) => Outlet.fromJson(e),
        )
        .toList();
  }

  @override
  Future<List<MRoute>> findAllRoutes() async {
    final result =
        await _database.rawQuery("SELECT * FROM Route ORDER BY routeName ASC");

    return result
        .map(
          (e) => MRoute.fromJson(e),
        )
        .toList();
  }

  @override
  Future<int> getPendingCount() async {
    final result = await _database.rawQuery(
        "SELECT COUNT() FROM Outlet LEFT JOIN OrderStatus ON Outlet.outletId = OrderStatus.outletId" +
            " WHERE  Outlet.planned=1 AND  ( ( OrderStatus.status < 2) OR ( Outlet.statusId < 2 ) )");

    if (result.isNotEmpty) {
      return Sqflite.firstIntValue(result) ?? 0;
    }

    return 0;
  }

  @override
  Future<int> getProductiveCount() async {
    final result = await _database.rawQuery(
        "SELECT COUNT() FROM Outlet LEFT JOIN OrderStatus ON Outlet.outletId = OrderStatus.outletId" +
            " WHERE  Outlet.planned=1 AND  ((OrderStatus.status >=8) OR (Outlet.statusId >=8))");

    if (result.isNotEmpty) {
      return Sqflite.firstIntValue(result) ?? 0;
    }

    return 0;
  }

  @override
  Future<int> getCompletedCount() async {
    final result = await _database.rawQuery(
        "SELECT COUNT() FROM Outlet LEFT JOIN OrderStatus ON Outlet.outletId = OrderStatus.outletId" +
            " WHERE  Outlet.planned=1 AND  ( (OrderStatus.status between 2 AND 7) OR (Outlet.statusId between 2 AND 7))");

    if (result.isNotEmpty) {
      return Sqflite.firstIntValue(result) ?? 0;
    }

    return 0;
  }

  @override
  Future<int> getPjpCount() async {
    final result =
        await _database.rawQuery("SELECT COUNT() FROM Outlet WHERE planned=1");

    if (result.isNotEmpty) {
      return Sqflite.firstIntValue(result) ?? 0;
    }

    return 0;
  }

  @override
  Future<List<OrderStatus>> findPendingOrderToSyncEx() async {
    final result = await _database.rawQuery(
        "SELECT * FROM OrderStatus WHERE status between 2 AND 8 AND requestStatus<3 ");

    return result
        .map(
          (e) => OrderStatus.fromJson(e),
        )
        .toList();
  }

  @override
  Future<void> deleteOrderAndAvailableTempQty() async{
    _database.rawQuery("DELETE FROM OrderAndAvailableQuantity");
  }

  @override
  Future<void> updateAvailableStockInOutlet(List<OutletModel>? outletList,List<AvailableStock> availableStock) async{
    _database.transaction((txn) async{
      Batch batch = txn.batch();
      for (OutletModel outlet in outletList ?? []) {
        List<AvailableStock> availableStockList = [];
        for (AvailableStock availableStock in availableStock) {
          if (availableStock.outletId == outlet.outletId) {
            availableStockList.add(availableStock);
          }
        }
        //Update avlStock Data in outlet
        outlet.avlStockDetail = availableStockList;
        batch.update("Outlet", outlet.toJson(),
            where: "outletId = ?", whereArgs: [outlet.outletId]);
        if (outlet.outletId != null) {
         Constants.outletIds.add(outlet.outletId!);
        }
      }
      await batch.commit(noResult: true);
    },);

  }
}
