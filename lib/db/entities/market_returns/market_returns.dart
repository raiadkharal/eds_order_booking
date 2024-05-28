import 'package:json_annotation/json_annotation.dart';

part 'market_returns.g.dart';

@JsonSerializable()
class MarketReturns {
  @JsonKey(name: 'outletId')
  final int? outletId;

  @JsonKey(name: 'invoiceId')
  final int? invoiceId;

  MarketReturns({
    this.outletId,
    this.invoiceId,
  });

  factory MarketReturns.fromJson(Map<String, dynamic> json) =>
      _$MarketReturnsFromJson(json);

  Map<String, dynamic> toJson() => _$MarketReturnsToJson(this);
}
