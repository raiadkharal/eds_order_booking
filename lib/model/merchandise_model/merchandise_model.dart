import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/db/entities/available_stock/available_stock.dart';

import '../../db/entities/merchandise/merchandise.dart';
part 'merchandise_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MerchandiseModel {
  @JsonKey(name: 'merchandise')
  Merchandise? merchandise;

  @JsonKey(name: 'dailyOutletStock')
  List<AvailableStock>? dailyOutletStock;

  @JsonKey(name: 'statusId')
  int? statusId;

  MerchandiseModel({
    this.merchandise,
    this.dailyOutletStock,
    this.statusId,
  });

  factory MerchandiseModel.fromJson(Map<String, dynamic> json) =>
      _$MerchandiseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MerchandiseModelToJson(this);
}
