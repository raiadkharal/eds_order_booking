// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_returns.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketReturns _$MarketReturnsFromJson(Map<String, dynamic> json) {
  return MarketReturns(
    outletId: json['outletId'] as int?,
    invoiceId: json['invoiceId'] as int?,
  );
}

Map<String, dynamic> _$MarketReturnsToJson(MarketReturns instance) =>
    <String, dynamic>{
      'outletId': instance.outletId,
      'invoiceId': instance.invoiceId,
    };
