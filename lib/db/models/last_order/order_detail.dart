import 'package:json_annotation/json_annotation.dart';

part 'order_detail.g.dart';

@JsonSerializable()
class OrderDetail {
  @JsonKey(name: 'productId')
  int? productId;

  @JsonKey(name: 'quantity')
   double? quantity;

  @JsonKey(name: 'productTotal')
   double? productTotal;

  @JsonKey(name: 'productName')
   String? productName;

  OrderDetail({
    required this.productId,
    required this.quantity,
    required this.productTotal,
    required this.productName,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => _$OrderDetailFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);
}
