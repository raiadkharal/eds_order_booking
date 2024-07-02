import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/db/entities/available_stock/available_stock.dart';
import 'package:order_booking/model/order_model/order_model.dart';
import 'package:order_booking/model/outlet_model/outlet_model.dart';

import '../../db/entities/asset/asset.dart';
import '../../db/entities/market_return_detail/market_return_detail.dart';
import '../../db/entities/promotion/promotion.dart';
import '../../db/entities/route/route.dart';
import '../../db/entities/task/task.dart';
import '../../db/models/base_response/base_response.dart';
import '../configuration/configurations_model.dart';
import '../lookup/lookup_model.dart';
import '../system_configuration/system_configuration.dart';
import '../target_vs_achievement/target_vs_achievement.dart';

part 'route_outlet_response_model.g.dart';

@JsonSerializable()
class RouteOutletResponseModel extends BaseResponse {
  @JsonKey(name: 'routes')
  List<MRoute>? routeList;

  @JsonKey(name: 'outlets')
  List<OutletModel>? outletList;

  @JsonKey(name: 'assets')
  List<Asset>? assetList;

  @JsonKey(name: 'distributionId')
  int? distributionId;

  @JsonKey(name: 'employeeName')
  String? employeeName;

  @JsonKey(name: 'configuration')
  ConfigurationModel? configuration;

  @JsonKey(name: 'targetVSAchievement')
  TargetVsAchievement? targetVsAchievement;

  @JsonKey(name: 'systemConfiguration')
  SystemConfiguration? systemConfiguration;

  @JsonKey(name: 'promosAndFOC')
  List<Promotion>? promosAndFOC;

  @JsonKey(name: 'tasks')
  List<Task>? tasks;

  @JsonKey(name: 'lookup')
  LookUpModel? lookUp;

  @JsonKey(name: 'orders')
  List<OrderModel>? orders;

  @JsonKey(name: 'deliveryDate')
  int? deliveryDate;

  @JsonKey(name: 'organizationId')
  int? organizationId;

  @JsonKey(name: 'warehouseId')
  int? warehouseId;

  @JsonKey(name: 'dailyOutletStock')
  List<AvailableStock>? dailyOutletStock;

  @JsonKey(name: 'marketReturns')
  List<MarketReturnDetail>? marketReturnDetails;

  RouteOutletResponseModel();

  factory RouteOutletResponseModel.fromJson(Map<String, dynamic> json) => _$RouteOutletResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RouteOutletResponseModelToJson(this);
}
