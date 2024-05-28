import 'package:json_annotation/json_annotation.dart';

part 'outlet_visit.g.dart';

@JsonSerializable()
class OutletVisit {
  final int? outletId;
  final int? visitTime;
  final double? latitude;
  final double? longitude;

  OutletVisit({
    this.outletId,
    this.visitTime,
    this.latitude,
    this.longitude,
  });

  factory OutletVisit.fromJson(Map<String, dynamic> json) => _$OutletVisitFromJson(json);
  Map<String, dynamic> toJson() => _$OutletVisitToJson(this);
}