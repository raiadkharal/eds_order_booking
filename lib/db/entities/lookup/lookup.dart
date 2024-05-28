import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../asset_status/asset_status.dart';
import '../market_return_reason/market_return_reasons.dart';

part 'lookup.g.dart';

@JsonSerializable()
class LookUp {
  @JsonKey(name: 'lookUpId')
  final int? lookUpId;

  @JsonKey(name: 'assetStatus')
  final List<AssetStatus>? assetStatus;

  @JsonKey(name: 'marketReturnReasons')
  final List<MarketReturnReason>? marketReturnReasons;

  LookUp({
    this.lookUpId,
    this.assetStatus,
    this.marketReturnReasons,
  });

  factory LookUp.fromJson(Map<String, dynamic> json) =>
      _$LookUpFromJson(json);

  Map<String, dynamic> toJson() => _$LookUpToJson(this);
}
