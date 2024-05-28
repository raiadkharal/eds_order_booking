// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outlet_visit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutletVisit _$OutletVisitFromJson(Map<String, dynamic> json) => OutletVisit(
  outletId: json['outletId'] as int?,
  visitTime: json['visitTime'] as int?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
);

Map<String, dynamic> _$OutletVisitToJson(OutletVisit instance) =>
    <String, dynamic>{
      'outletId': instance.outletId,
      'visitTime': instance.visitTime,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
