import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/db/entities/available_stock/available_stock.dart';

import '../merchandise_model/merchandise_model.dart';


part 'merchandise_upload_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MerchandiseUploadModel {
  @JsonKey(name: 'merchandise')
  MerchandiseModel? merchandise;

  @JsonKey(name: 'dailyOutletStock')
  List<AvailableStock>? dailyOutletStock;

  @JsonKey(name: 'statusId')
  int? statusId;

  MerchandiseUploadModel({
    this.merchandise,
    this.dailyOutletStock,
    this.statusId,
  });

  factory MerchandiseUploadModel.fromJson(Map<String, dynamic> json) =>
      _$MerchandiseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MerchandiseModelToJson(this);
}
