part of 'free_good_entity_details.dart';

FreeGoodEntityDetails _$FreeGoodEntityDetailsFromJson(Map<String, dynamic> json) {
  return FreeGoodEntityDetails(
    freeGoodEntityDetailId: json['freeGoodEntityDetailId'] as int,
    freeGoodMasterId: json['freeGoodMasterId'] as int,
    outletId: json['outletId'] as int,
    routeId: json['routeId'] as int,
    distributionId: json['distributionId'] as int,
    channelId: json['channelId'] as int,
    entityCode: json['entityCode'] as String,
    entityText: json['entityText'] as String,
    status: json['status'] as String,
    location: json['location'] as String,
    address: json['address'] as String,
    channel: json['channel'] as String,
  );
}

Map<String, dynamic> _$FreeGoodEntityDetailsToJson(FreeGoodEntityDetails instance) => <String, dynamic>{
  'freeGoodEntityDetailId': instance.freeGoodEntityDetailId,
  'freeGoodMasterId': instance.freeGoodMasterId,
  'outletId': instance.outletId,
  'routeId': instance.routeId,
  'distributionId': instance.distributionId,
  'channelId': instance.channelId,
  'entityCode': instance.entityCode,
  'entityText': instance.entityText,
  'status': instance.status,
  'location': instance.location,
  'address': instance.address,
  'channel': instance.channel,
};
