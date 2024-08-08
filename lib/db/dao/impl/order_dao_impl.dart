import 'dart:convert';

import 'package:order_booking/db/dao/order_dao.dart';
import 'package:order_booking/db/entities/order_status/order_status.dart';
import 'package:order_booking/model/order_detail_and_price_breakdown/order_detail_and_price_breakdown.dart';
import 'package:order_booking/model/outlet_model/outlet_model.dart';
import 'package:order_booking/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/order_model_response/order_model_response.dart';
import '../../entities/carton_price_breakdown/carton_price_breakdown.dart';
import '../../entities/order/order.dart';
import '../../entities/order_detail/order_detail.dart';
import '../../entities/order_quantity/order_quantity.dart';
import '../../entities/outlet/outlet.dart';
import '../../entities/unit_price_breakdown/unit_price_breakdown.dart';

class OrderDaoImpl extends OrderDao {
  final Database _database;

  OrderDaoImpl(this._database);

  @override
  Future<void> insertOrder(Order order) async {
    _database.insert("`Order`", order.toJson(),
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
        where: "fk_oid= ? AND packageId= ?", whereArgs: [id, packageId]);
  }

  @override
  Future<void> insertOrderItems(List<OrderDetail>? orderDetails) async {
    if (orderDetails != null) {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          for (OrderDetail orderDetail in orderDetails) {
            batch.insert("OrderDetail", orderDetail.toJson(),
                conflictAlgorithm: ConflictAlgorithm.replace);
          }
          await batch.commit(noResult: true);
        },
      );
    }
  }

  @override
  Future<OrderEntityModel?> getOrderWithItems(int? outletId) async {
    return await _database.transaction((txn) async {
      // Query to get the order
      const String orderQuery = '''
      SELECT * FROM `Order` 
      WHERE outletId = ?
    ''';

      List<Map<String, dynamic>> orderResult =
          await txn.rawQuery(orderQuery, [outletId]);

      if (orderResult.isNotEmpty) {
        // Map the order result to an Order object
        Order order = Order.fromJson(orderResult.first);

        // Query to get the items related to the order
        const String itemsQuery = '''
        SELECT * FROM Outlet 
        WHERE outletId = ?
      ''';

        List<Map<String, dynamic>> outletResult =
            await txn.rawQuery(itemsQuery, [outletId]);

        Outlet outlet = Outlet.fromJson(outletResult.first);

        List<OrderDetailAndPriceBreakdown> orderDetailAndPriceBreakdownList =
            [];

        //fetch order detail by order id
        const String orderDetailQuery =
            "select * from OrderDetail where fk_oid = ?";
        List<Map<String, dynamic>> orderDetailResult =
            await txn.rawQuery(orderDetailQuery, [order.id]);
        List<OrderDetail> orderDetails = orderDetailResult
            .map(
              (e) => OrderDetail.fromJson(e),
            )
            .toList();

        //fetch breakdown using orderDetail id
        for (OrderDetail orderDetail in orderDetails) {
          OrderDetailAndPriceBreakdown orderDetailAndPriceBreakdown =
              OrderDetailAndPriceBreakdown(orderDetail: OrderDetail());

          const String cartonPriceBreakdownQuery =
              "select * from CartonPriceBreakDown where mobileOrderDetailId = ?";
          List<Map<String, dynamic>> cartonPriceBreakdownResult = await txn
              .rawQuery(cartonPriceBreakdownQuery, [orderDetail.orderDetailId]);
          List<CartonPriceBreakDown> cartonPriceBreakDownList =
              cartonPriceBreakdownResult
                  .map(
                    (e) => CartonPriceBreakDown.fromJson(e),
                  )
                  .toList();

          const String unitPriceBreakdownQuery =
              "select * from UnitPriceBreakDown where mobileOrderDetailId = ?";
          List<Map<String, dynamic>> unitPriceBreakdownResult = await txn
              .rawQuery(unitPriceBreakdownQuery, [orderDetail.orderDetailId]);
          List<UnitPriceBreakDown> unitPriceBreakDownList =
              unitPriceBreakdownResult
                  .map(
                    (e) => UnitPriceBreakDown.fromJson(e),
                  )
                  .toList();

          orderDetailAndPriceBreakdown.orderDetail = orderDetail;
          orderDetailAndPriceBreakdown.cartonPriceBreakDownList =
              cartonPriceBreakDownList;
          orderDetailAndPriceBreakdown.unitPriceBreakDownList =
              unitPriceBreakDownList;

          orderDetailAndPriceBreakdownList.add(orderDetailAndPriceBreakdown);
        }

        // Return the combined result
        return OrderEntityModel(
            order: order,
            outlet: outlet,
            orderDetailAndCPriceBreakdowns: orderDetailAndPriceBreakdownList);
      }

      return null;
    });
  }

  @override
  Future<Order> findOrderById(int? mobileOrderId) async {
    final result = await _database
        .query("`Order`", where: "pk_oid = ?", whereArgs: [mobileOrderId]);

    return Order.fromJson(result.first);
  }

  @override
  Future<void> updateOrder(Order? order) async {
    try {
      if (order != null) {
        _database.update("`Order`", order.toJson(),where: "pk_oid=?",whereArgs: [order.id]);
        // _database.rawQuery(
        // "update  `Order` set outletId = ${order.outletId}, serverOrderId = ${order.serverOrderId}, routeId = ${order.routeId},code = ${order.code},orderStatusId = ${order.orderStatus},visitDayId = ${order.visitDayId},latitude = ${order.latitude},longitude = ${order.longitude},subtotal = ${order.subTotal},payable = ${order.payable},orderDate = ${order.orderDate},deliveryDate = ${order.deliveryDate},distributionId = ${order.distributionId},priceBreakDown = ${jsonEncode(order.priceBreakDown)},orderDetails = '' where outletId = ${order.outletId}");
      }
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> deleteOrderItems(int? orderId) async {
    if (orderId != null) {
      _database
          .delete("OrderDetail", where: "fk_oid = ?", whereArgs: [orderId]);
    }
  }

  @override
  Future<void> insertUnitPriceBreakDown(
      List<UnitPriceBreakDown>? unitPriceBreakDown) async {
    if (unitPriceBreakDown != null) {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();

          for (UnitPriceBreakDown item in unitPriceBreakDown) {
            batch.insert("UnitPriceBreakDown", item.toJson(),
                conflictAlgorithm: ConflictAlgorithm.replace);
          }
          await batch.commit(noResult: true);
        },
      );
    }
  }

  @override
  Future<void> insertCartonPriceBreakDown(
      List<CartonPriceBreakDown>? cartonPriceBreakDown) async {
    if (cartonPriceBreakDown != null) {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();

          for (CartonPriceBreakDown item in cartonPriceBreakDown) {
            batch.insert("CartonPriceBreakDown", item.toJson(),
                conflictAlgorithm: ConflictAlgorithm.replace);
          }
          await batch.commit(noResult: true);
        },
      );
    }
  }

  @override
  Future<void> deleteAllOrders() async {
    _database.delete("'Order'");
  }

  @override
  Future<void> deleteOrderCartonPriceBreakdown(int? orderDetailId) async{
    _database.delete("CartonPriceBreakDown",where: "mobileOrderDetailId = ?",whereArgs: [orderDetailId]);
  }

  @override
  Future<void> deleteOrderUnitPriceBreakdown(int? orderDetailId) async{
    _database.delete("UnitPriceBreakDown",where: "mobileOrderDetailId = ?",whereArgs: [orderDetailId]);
  }

  @override
  Future<void> insertOrderAndAvailableStockData(
      List<OrderAndAvailableQuantity> orderQuantityList) async{
    await _database.transaction((txn) async{
      Batch batch = txn.batch();

      for(OrderAndAvailableQuantity orderQuantity in orderQuantityList){
        batch.insert("OrderAndAvailableQuantity", orderQuantity.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);

    },);
  }

  @override
  Future<void> deleteOrderAndAvailableStockByOutlet(int? outletId)async {
    _database.delete("OrderAndAvailableQuantity",where: "outletId = ?",whereArgs: [outletId]);
  }

  @override
  Future<List<OrderAndAvailableQuantity>> getOrderAndAvailableQuantityDataByOutlet(int? outletId) async{

    if(outletId==null) return [];

    final result = await _database.query("OrderAndAvailableQuantity",where: "outletId = ?",whereArgs: [outletId]);

    return result.map((e) => OrderAndAvailableQuantity.fromJson(e),).toList();
  }

  @override
  Future<List<OrderEntityModel>> findAllOrders() async{
    return await _database.transaction((txn) async {

      List<OrderEntityModel> orderList = [];
      // Query to get the order
      const String orderQuery = '''
      SELECT * FROM 'Order' WHERE outletId IN (SELECT outletId From Outlet where visitStatus in (7,8) OR statusId in (7, 8))
    ''';

      List<Map<String, dynamic>> orderResult =
      await txn.rawQuery(orderQuery);

      if (orderResult.isNotEmpty) {
        // Map the order result to an Order object
        List<Order> orders = orderResult.map((e) => Order.fromJson(e),).toList();
        for (Order order in orders) {
          // Query to get the outlet of order
          const String outletQuery = '''
          SELECT * FROM Outlet 
          WHERE outletId = ?
        ''';

          List<Map<String, dynamic>> outletResult =
          await txn.rawQuery(outletQuery, [order.outletId]);

          Outlet outlet = Outlet.fromJson(outletResult.first);

          //fetch order status
          const String orderStatusQuery = '''
          SELECT * FROM OrderStatus 
          WHERE orderId = ?
        ''';

          List<Map<String, dynamic>> orderStatusResult =
          await txn.rawQuery(orderStatusQuery, [order.id]);

          OrderStatus orderStatus = OrderStatus.fromJson(orderStatusResult.first);

          List<OrderDetailAndPriceBreakdown> orderDetailAndPriceBreakdownList =
          [];

          //fetch order detail by order id
          const String orderDetailQuery =
              "select * from OrderDetail where fk_oid = ?";
          List<Map<String, dynamic>> orderDetailResult =
          await txn.rawQuery(orderDetailQuery, [order.id]);
          List<OrderDetail> orderDetails = orderDetailResult
              .map(
                (e) => OrderDetail.fromJson(e),
          )
              .toList();

          //fetch breakdown using orderDetail id
          for (OrderDetail orderDetail in orderDetails) {
            OrderDetailAndPriceBreakdown orderDetailAndPriceBreakdown =
            OrderDetailAndPriceBreakdown(orderDetail: OrderDetail());

            const String cartonPriceBreakdownQuery =
                "select * from CartonPriceBreakDown where mobileOrderDetailId = ?";
            List<Map<String, dynamic>> cartonPriceBreakdownResult = await txn
                .rawQuery(cartonPriceBreakdownQuery, [orderDetail.orderDetailId]);
            List<CartonPriceBreakDown> cartonPriceBreakDownList =
            cartonPriceBreakdownResult
                .map(
                  (e) => CartonPriceBreakDown.fromJson(e),
            )
                .toList();

            const String unitPriceBreakdownQuery =
                "select * from UnitPriceBreakDown where mobileOrderDetailId = ?";
            List<Map<String, dynamic>> unitPriceBreakdownResult = await txn
                .rawQuery(unitPriceBreakdownQuery, [orderDetail.orderDetailId]);
            List<UnitPriceBreakDown> unitPriceBreakDownList =
            unitPriceBreakdownResult
                .map(
                  (e) => UnitPriceBreakDown.fromJson(e),
            )
                .toList();

            orderDetailAndPriceBreakdown.orderDetail = orderDetail;
            orderDetailAndPriceBreakdown.cartonPriceBreakDownList =
                cartonPriceBreakDownList;
            orderDetailAndPriceBreakdown.unitPriceBreakDownList =
                unitPriceBreakDownList;

            orderDetailAndPriceBreakdownList.add(orderDetailAndPriceBreakdown);
          }

          // Return the combined result
          final OrderEntityModel orderModel  = OrderEntityModel(
              order: order,
              outlet: outlet,
              orderStatus: orderStatus,
              orderDetailAndCPriceBreakdowns: orderDetailAndPriceBreakdownList);

          orderList.add(orderModel);
        }
      }

      return orderList;
    });
  }
}
