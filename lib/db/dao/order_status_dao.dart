import 'package:order_booking/db/entities/order_status/order_status.dart';
import 'package:order_booking/model/upload_status_model/upload_status_model.dart';

abstract class OrderStatusDao {
  Future<void> insertStatus(OrderStatus status);

  Future<OrderStatus?> findOutletOrderStatus(int outletId);

  Future<void> update(OrderStatus? status);

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
      int? outletVisitStartTime);

  Future<void> deleteAllStatus();

  Future<int> getTotalSyncCount();

 Future<List<UploadStatusModel>> getAllOrders();
}
