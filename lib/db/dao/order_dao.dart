import 'package:order_booking/db/entities/order_status/order_status.dart';
import 'package:order_booking/model/order_detail_model/order_detail_model.dart';
import 'package:order_booking/model/order_model_response/order_model_response.dart';

import '../entities/order/order.dart';
import '../entities/order_detail/order_detail.dart';
abstract class OrderDao {
  Future<void> insertOrder(Order order);

  Future<void> insertOrderStatus(OrderStatus orderStatus);

  Future<void> insertOrderItem(OrderDetail orderDetail);

  Future<void> deleteOrderItemsByPkg(int? id, int? packageId);

  Future<void> insertOrderItems(List<OrderDetail> orderDetails);

  Future<OrderEntityModel?> getOrderWithItems(int? outletId);

}