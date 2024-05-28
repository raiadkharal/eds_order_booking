import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import '../../models/merchandise_images/merchandise_image.dart';
import '../asset/asset.dart';

part 'merchandise.g.dart';

@JsonSerializable()
class Merchandise {
  @JsonKey(name: 'outletId')
  final int? outletId;

  @JsonKey(name: 'remarks')
  final String? remarks;

  @JsonKey(name: 'merchandiseImages')
  final List<MerchandiseImage>? merchandiseImages;

  @JsonKey(name: 'assets')
  final List<Asset>? assetList;

  Merchandise({
    this.outletId,
    this.remarks,
    this.merchandiseImages,
    this.assetList,
  });

  factory Merchandise.fromJson(Map<String, dynamic> json) =>
      _$MerchandiseFromJson(json);

  Map<String, dynamic> toJson() => _$MerchandiseToJson(this);
}
