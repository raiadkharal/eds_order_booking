import 'package:order_booking/db/dao/order_dao.dart';
import 'package:order_booking/db/entities/order_status/order_status.dart';
import 'package:order_booking/model/outlet_model/outlet_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/order_model_response/order_model_response.dart';
import '../../entities/order/order.dart';
import '../../entities/order_detail/order_detail.dart';
import '../../entities/outlet/outlet.dart';

class OrderDaoImpl extends OrderDao {
  final Database _database;

  OrderDaoImpl(this._database);

  @override
  Future<void> insertOrder(Order order) async {
    _database.insert("Order", order.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> insertOrderStatus(OrderStatus orderStatus) async {
    _database.insert("OrderStatus", orderStatus.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> insertOrderItem(OrderDetail orderDetail) async {
    _database.insert("OrderDetail", orderDetail.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteOrderItemsByPkg(int? id, int? packageId) async {
    _database.delete("OrderDetail",
        where: "WHERE fk_oid= ? AND packageId= ?", whereArgs: [id, packageId]);
  }

  @override
  Future<void> insertOrderItems(List<OrderDetail> orderDetails) async {
    for (OrderDetail orderDetail in orderDetails) {
      _database.insert("OrderDetail", orderDetail.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  @override
  Future<OrderEntityModel?> getOrderWithItems(int? outletId) async{
    return await _database.transaction((txn) async {
      // Query to get the order
      const String orderQuery = '''
      SELECT * FROM `Order` 
      WHERE c_outletId = ?
    ''';

      List<Map<String, dynamic>> orderResult = await txn.rawQuery(
          orderQuery, [outletId]);

      if (orderResult.isNotEmpty) {
        // Map the order result to an Order object
        Order order = Order.fromJson(orderResult.first);

        // Query to get the items related to the order
        const String itemsQuery = '''
        SELECT * FROM Outlet 
        WHERE outletId = ?
      ''';

        List<Map<String, dynamic>> outletResult = await txn.rawQuery(
            itemsQuery, [outletId]);

        Outlet outlet = Outlet.fromJson(outletResult.first);

        // Return the combined result
        return OrderEntityModel(order: order, outlet: outlet);
      }

      return null;
    });
  }
}
