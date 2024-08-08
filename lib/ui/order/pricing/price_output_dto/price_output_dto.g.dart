// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_output_dto.dart';

PriceOutputDTO _$PriceOutputDTOFromJson(Map<String, dynamic> json) {
  return PriceOutputDTO(
    totalPrice: json['TotalPrice'] as double,
    priceBreakdown: (json['PriceBreakdown'] as List<dynamic>)
        .map((e) => UnitPriceBreakDown.fromJson(e as Map<String, dynamic>))
        .toList(),
    messages: (json['Messages'] as List<dynamic>)
        .map((e) => Message.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PriceOutputDTOToJson(PriceOutputDTO instance) =>
    <String, dynamic>{
      'TotalPrice': instance.totalPrice,
      'PriceBreakdown': instance.priceBreakdown?.map((e) => e.toJson()).toList(),
      'Messages': instance.messages?.map((e) => e.toJson()).toList(),
    };
