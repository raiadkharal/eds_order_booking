// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemConfiguration _$SystemConfigurationFromJson(Map<String, dynamic> json) {
  return SystemConfiguration(
    canNotPunchOrderInUnits: json['canNotPunchOrderInUnits'] as bool?,
    hideCustomerInfoInOrderingApp: json['hideCustomerInfoInOrderingApp'] as bool?,
    productFilter: json['productFilter'] as String?,
    productView: json['productView'] as String?,
    showMarketReturnsButton: json['showMarketReturnsButton'] as bool?,
  );
}

Map<String, dynamic> _$SystemConfigurationToJson(SystemConfiguration instance) => <String, dynamic>{
  'canNotPunchOrderInUnits': instance.canNotPunchOrderInUnits,
  'hideCustomerInfoInOrderingApp': instance.hideCustomerInfoInOrderingApp,
  'productFilter': instance.productFilter,
  'productView': instance.productView,
  'showMarketReturnsButton': instance.showMarketReturnsButton,
};
