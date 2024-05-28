// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_return_reasons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketReturnReason _$MarketReturnReasonFromJson(Map<String, dynamic> json) {
  return MarketReturnReason(
    id: json['id'] as int?,
    marketReturnReason: json['marketReturnReason'] as String?,
    returnedProductTypeId: json['returnedProductTypeId'] as int?,
  );
}

Map<String, dynamic> _$MarketReturnReasonToJson(MarketReturnReason instance) =>
    <String, dynamic>{
      'id': instance.id,
      'marketReturnReason': instance.marketReturnReason,
      'returnedProductTypeId': instance.returnedProductTypeId,
    };
