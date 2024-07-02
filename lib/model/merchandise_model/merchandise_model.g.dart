// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchandise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchandiseModel _$MerchandiseModelFromJson(Map<String, dynamic> json) =>
    MerchandiseModel(
      merchandise: json['merchandise'] == null
          ? null
          : Merchandise.fromJson(json['merchandise'] as Map<String, dynamic>),
      dailyOutletStock: (json['dailyOutletStock'] as List<dynamic>?)
          ?.map((e) => AvailableStock.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusId: json['statusId'] as int?,
    );

Map<String, dynamic> _$MerchandiseModelToJson(MerchandiseModel instance) =>
    <String, dynamic>{
      'merchandise': instance.merchandise?.toJson(),
      'dailyOutletStock':
      instance.dailyOutletStock?.map((e) => e.toJson()).toList(),
      'statusId': instance.statusId,
    };
