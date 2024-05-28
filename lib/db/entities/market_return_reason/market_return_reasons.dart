import 'package:json_annotation/json_annotation.dart';

part 'market_return_reasons.g.dart';

@JsonSerializable()
class MarketReturnReason {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'marketReturnReason')
  final String? marketReturnReason;

  @JsonKey(name: 'returnedProductTypeId')
  final int? returnedProductTypeId;

  MarketReturnReason({
    this.id,
    this.marketReturnReason,
    this.returnedProductTypeId,
  });

  factory MarketReturnReason.fromJson(Map<String, dynamic> json) =>
      _$MarketReturnReasonFromJson(json);

  Map<String, dynamic> toJson() => _$MarketReturnReasonToJson(this);
}
