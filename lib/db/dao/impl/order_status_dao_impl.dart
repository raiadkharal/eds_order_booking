import 'package:order_booking/db/dao/order_status_dao.dart';
import 'package:order_booking/db/entities/order_status/order_status.dart';
import 'package:order_booking/model/upload_status_model/upload_status_model.dart';
import 'package:sqflite/sqflite.dart';

class OrderStatusDaoImpl extends OrderStatusDao {
  final Database _database;

  OrderStatusDaoImpl(this._database);

  @override
  Future<void> insertStatus(OrderStatus status) async {
    _database.insert("OrderStatus", status.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<OrderStatus?> findOutletOrderStatus(int outletId) async {
    final result = await _database
        .query("OrderStatus", where: "outletId = ?", whereArgs: [outletId]);

    if (result.isNotEmpty) {
      return OrderStatus.fromJson(result.first);
    }

    return null;
  }

  @override
  Future<void> update(OrderStatus? status) async {
    if (status != null) {
      _database.update("OrderStatus", status.toJson(),
          where: "outletId = ?", whereArgs: [status.outletId]);
    }
  }

  @override
  Future<void> updateStatus(
      int? status,
      int? outletId,
      bool? synced,
      double? orderAmount,
      String? data,
      int? outletVisitEndTime,
      int? outletDistance,
      double? outletLatitude,
      double? outletLongitude,
      int? outletVisitStartTime) async {
    _database.rawUpdate(
        "UPDATE OrderStatus Set status=?, sync=?,orderAmount=?,outletVisitEndTime=?, data=?, outletDistance=?,outletLatitude=?,outletLongitude=?, outletVisitStartTime=? WHERE outletId=?",
        [
          status,
          synced,
          orderAmount,
          outletVisitEndTime,
          data,
          outletDistance,
          outletLatitude,
          outletLongitude,
          outletVisitStartTime,
          outletId
        ]);
  }

  @override
  Future<void> deleteAllStatus() async {
    _database.rawQuery("DELETE FROM OrderStatus");
  }

  @override
  Future<int> getTotalSyncCount() async {
    final result = await _database.rawQuery(
        "SELECT count(*) from Outlet where  statusId>0 and (synced =1 or synced is null)");

    if (result.isNotEmpty) {
      return Sqflite.firstIntValue(result) ?? 0;
    }

    return 0;
  }

  @override
  Future<List<UploadStatusModel>> getAllOrders() async{
    final result = await _database.rawQuery("SELECT o.outletId, o.outletName, ifnull(o.synced,1) as 'synced',os.imageStatus, os.requestStatus FROM Outlet o INNER JOIN OrderStatus os ON os.outletId=o.outletId where (o.synced is not null And os.data is not null) or (o.synced is not null and o.statusId>1) order by synced");

    return result.map((e) => UploadStatusModel.fromJson(e),).toList();
  }
}
