import 'package:json_annotation/json_annotation.dart';

part 'system_configuration.g.dart';

@JsonSerializable()
class SystemConfiguration {
  @JsonKey(name: 'canNotPunchOrderInUnits')
  final bool? canNotPunchOrderInUnits;

  @JsonKey(name: 'hideCustomerInfoInOrderingApp')
  final bool? hideCustomerInfoInOrderingApp;

  @JsonKey(name: 'productFilter')
  final String? productFilter;

  @JsonKey(name: 'productView')
  final String? productView;

  @JsonKey(name: 'showMarketReturnsButton')
  final bool showMarketReturnsButton;

  SystemConfiguration({
    this.canNotPunchOrderInUnits,
    this.hideCustomerInfoInOrderingApp,
    this.productFilter,
    this.productView,
    required this.showMarketReturnsButton,
  });

  // A factory method for creating a new instance from a map.
  factory SystemConfiguration.fromJson(Map<String, dynamic> json) => _$SystemConfigurationFromJson(json);

  // A method for converting an instance into a map.
  Map<String, dynamic> toJson() => _$SystemConfigurationToJson(this);
}
