// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchandise_upload_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchandiseUploadModel _$MerchandiseModelFromJson(Map<String, dynamic> json) =>
    MerchandiseUploadModel(
      merchandise: json['merchandise'] == null
          ? null
          : MerchandiseModel.fromJson(json['merchandise'] as Map<String, dynamic>),
      dailyOutletStock: (json['dailyOutletStock'] as List<dynamic>?)
          ?.map((e) => AvailableStock.fromJson(e as Map<String, dynamic>))
          .toList(),
      statusId: json['statusId'] as int?,
    );

Map<String, dynamic> _$MerchandiseModelToJson(MerchandiseUploadModel instance) =>
    <String, dynamic>{
      'merchandise': instance.merchandise?.toJson(),
      'dailyOutletStock':
      instance.dailyOutletStock?.map((e) => e.toJson()).toList(),
      'statusId': instance.statusId,
    };
