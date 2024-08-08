import 'package:json_annotation/json_annotation.dart';

import '../../db/entities/market_return_detail/market_return_detail.dart';

part 'market_return_model.g.dart';

@JsonSerializable()
class MarketReturnsModel {
  @JsonKey(name: 'organizationId')
  int? organizationId;

  @JsonKey(name: 'routeId')
  int?  routeId;

  @JsonKey(name: 'distributionId')
  int? distributionId;

  @JsonKey(name: 'warehouseId')
  int? warehouseId;

  @JsonKey(name: 'salesmanId')
  int? salesmanId;

  @JsonKey(name: 'invoiceId')
  int? invoiceId;

  @JsonKey(name: 'outletId')
  int?  outletId;

  @JsonKey(name: 'orderDate')
  int? orderDate;

  @JsonKey(name: 'deliveryDate')
  int? deliveryDate;

  @JsonKey() // Assuming you don't want to serialize the list directly
  List<MarketReturnDetail>? marketReturnDetails;

  MarketReturnsModel({
    this.organizationId,
    this.routeId,
    this.distributionId,
    this.warehouseId,
    this.salesmanId,
    this.invoiceId,
    this.outletId,
    this.orderDate,
    this.deliveryDate,
    this.marketReturnDetails,
  });

  factory MarketReturnsModel.fromJson(Map<String, dynamic> json) =>
      _$MarketReturnsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MarketReturnsModelToJson(this);
}
