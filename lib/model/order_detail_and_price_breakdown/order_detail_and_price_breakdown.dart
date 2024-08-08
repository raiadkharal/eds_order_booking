import 'package:json_annotation/json_annotation.dart';

import '../../db/entities/carton_price_breakdown/carton_price_breakdown.dart';
import '../../db/entities/order_detail/order_detail.dart';
import '../../db/entities/unit_price_breakdown/unit_price_breakdown.dart';

part 'order_detail_and_price_breakdown.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDetailAndPriceBreakdown {
  OrderDetail orderDetail;
  List<CartonPriceBreakDown>? cartonPriceBreakDownList;
  List<UnitPriceBreakDown>? unitPriceBreakDownList;

  OrderDetailAndPriceBreakdown({
   required this.orderDetail,
   this.cartonPriceBreakDownList,
   this.unitPriceBreakDownList,
  });

  factory OrderDetailAndPriceBreakdown.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailAndPriceBreakdownFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailAndPriceBreakdownToJson(this);
}