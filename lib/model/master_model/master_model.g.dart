// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterModel _$MasterModelFromJson(Map<String, dynamic> json) => MasterModel()
  ..outletId = json['outletId'] as int?
  ..outletCode = json['outletCode'] as String?
  ..outletStatus = json['outletStatus'] as int?
  ..reason = json['reason'] as String?
  ..requestCounter = json['requestCounter'] as int?
  ..salesmanId = json['salesmanId'] as int?
  ..outletVisitTime = json['outletVisitTime'] as int?
  ..outletEndTime = json['outletEndTime'] as int?
  ..dailyOutletVisit = json['dailyOutletVisit'] == null
      ? null
      : MerchandiseModel.fromJson(json['dailyOutletVisit'] as Map<String, dynamic>)
  ..latitude = (json['latitude'] as num?)?.toDouble()
  ..longitude = (json['longitude'] as num?)?.toDouble()
  ..customerInput = json['customerInput'] == null
      ? null
      : CustomerInput.fromJson(json['customerInput'] as Map<String, dynamic>)
  ..order = json['order'] == null
      ? null
      : OrderResponseModel.fromJson(json['order'] as Map<String, dynamic>)
  ..marketReturns = json['marketReturns'] == null
      ? null
      : MarketReturnsModel.fromJson(json['marketReturns'] as Map<String, dynamic>)
  ..tasks = (json['tasks'] as List<dynamic>?)
      ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
      .toList()
  ..outletLatitude = (json['outletLatitude'] as num?)?.toDouble()
  ..outletLongitude = (json['outletLongitude'] as num?)?.toDouble()
  ..outletDistance = json['outletDistance'] as double?
  ..outletVisits = (json['outletVisits'] as List<dynamic>?)
      ?.map((e) => OutletVisit.fromJson(e as Map<String, dynamic>))
      .toList()
  ..startedDate = json['startedDate'] as int?;

Map<String, dynamic> _$MasterModelToJson(MasterModel instance) {
  Map<String, dynamic> json = {
    'outletId': instance.outletId,
    'outletCode': instance.outletCode,
    'outletStatus': instance.outletStatus,
    'reason': instance.reason,
    'requestCounter': instance.requestCounter,
    'salesmanId': instance.salesmanId,
    'outletVisitTime': instance.outletVisitTime,
    'outletEndTime': instance.outletEndTime,
    'dailyOutletVisit': instance.dailyOutletVisit?.toJson(),
    'latitude': instance.latitude,
    'longitude': instance.longitude,
    'customerInput': instance.customerInput?.toJson(),
    'order': instance.order?.toJson(),
    'marketReturns': instance.marketReturns?.toJson(),
    'tasks': instance.tasks?.map((e) => e.toJson()).toList(),
    'outletLatitude': instance.outletLatitude,
    'outletLongitude': instance.outletLongitude,
    'outletDistance': instance.outletDistance,
    'outletVisits': instance.outletVisits?.map((e) => e.toJson()).toList(),
    'startedDate': instance.startedDate,
  };

  // json.removeWhere((key, value) => value==null,);

  return json;
}
