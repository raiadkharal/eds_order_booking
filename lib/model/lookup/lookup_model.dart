import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/db/entities/market_return_reason/market_return_reasons.dart';
import 'package:order_booking/db/entities/market_returns/market_returns.dart';
import 'package:order_booking/model/asset_status_model/asset_status_model.dart';

part 'lookup_model.g.dart';

@JsonSerializable()
class LookUpModel {
  @JsonKey(name: 'lookUpId')
  final int? lookUpId;

  @JsonKey(name: 'assetStatus')
  final List<AssetStatusModel>? assetStatus;

  @JsonKey(name: 'marketReturnReasons')
  final List<MarketReturnReason>? marketReturnReasons;

  LookUpModel({
    this.lookUpId,
    this.assetStatus,
    this.marketReturnReasons,
  });

  factory LookUpModel.fromJson(Map<String, dynamic> json) =>
      _$LookUpFromJson(json);

  Map<String, dynamic> toJson() => _$LookUpToJson(this);
}
