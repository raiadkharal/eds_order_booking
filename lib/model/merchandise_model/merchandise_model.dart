import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/db/entities/asset/asset.dart';
import 'package:order_booking/model/asset_model/asset_model.dart';

import '../../db/models/merchandise_images/merchandise_image.dart';

part 'merchandise_model.g.dart';

@JsonSerializable()
class MerchandiseModel {
  @JsonKey(name: 'outletId')
  int? outletId;

  @JsonKey(name: 'remarks')
  String? remarks;

  @JsonKey(name: 'merchandiseImages')
  List<MerchandiseImage>? merchandiseImages;

  @JsonKey(name: 'assets')
  List<AssetModel>? assetList;

  MerchandiseModel({
    this.outletId,
    this.remarks,
    this.merchandiseImages,
    this.assetList,
  });

  factory MerchandiseModel.fromJson(Map<String, dynamic> json) =>
      _$MerchandiseFromJson(json);

  Map<String, dynamic> toJson() => _$MerchandiseToJson(this);
}
