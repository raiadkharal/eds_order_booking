import 'dart:collection';

import 'package:order_booking/db/entities/carton_price_breakdown/carton_price_breakdown.dart';
import 'package:order_booking/db/entities/order_quantity/order_quantity.dart';
import 'package:order_booking/db/entities/order_status/order_status.dart';
import 'package:order_booking/db/entities/unit_price_breakdown/unit_price_breakdown.dart';
import 'package:order_booking/model/order_detail_model/order_detail_model.dart';
import 'package:order_booking/model/order_model/order_model.dart';
import 'package:order_booking/model/order_model_response/order_model_response.dart';

import '../entities/order/order.dart';
import '../entities/order_detail/order_detail.dart';
abstract class OrderDao {
  Future<void> insertOrder(Order order);

  Future<void> insertOrderStatus(OrderStatus orderStatus);

  Future<void> insertOrderItem(OrderDetail orderDetail);

  Future<void> deleteOrderItemsByPkg(int? id, int? packageId);

  Future<void> insertOrderItems(List<OrderDetail>? orderDetails);

  Future<OrderEntityModel?> getOrderWithItems(int? outletId);

  Future<Order?> findOrderById(int? mobileOrderId);

  Future<void> updateOrder(Order? order);

  Future<void> deleteOrderItems(int? orderId);

  Future<void> insertUnitPriceBreakDown(List<UnitPriceBreakDown>? unitPriceBreakDown);

  Future<void> insertCartonPriceBreakDown(List<CartonPriceBreakDown>? cartonPriceBreakDown);

  Future<void> deleteAllOrders();

  Future<void> deleteOrderUnitPriceBreakdown(int? orderDetailId);

  Future<void> deleteOrderCartonPriceBreakdown(int? orderDetailId);

  Future<void> insertOrderAndAvailableStockData(List<OrderAndAvailableQuantity> orderQuantityList);

  Future<void> deleteOrderAndAvailableStockByOutlet(int? outletId);

  Future<List<OrderAndAvailableQuantity>> getOrderAndAvailableQuantityDataByOutlet(int? outletId);

  Future<List<OrderEntityModel>> findAllOrders();

  Future<void> insertOrders(List<OrderModel>? orders,List<int> outletIds);

  Future<void> insertOrderStatuses(List<OrderModel>? orders,List<int> outletIds);

  Future<void> insertOrderDetails(List<OrderModel>? orders,List<int> outletIds, HashMap<String, int> productH);

}