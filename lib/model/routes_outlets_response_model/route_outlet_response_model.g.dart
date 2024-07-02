// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_outlet_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteOutletResponseModel _$RouteOutletResponseModelFromJson(Map<String, dynamic> json) =>
    RouteOutletResponseModel()
      ..errorMessage = json['errorMessage'] as String?
      ..success = json['success'] as String?
      ..errorCode = json['errorCode'] as int?
      ..routeList = (json['routes'] as List<dynamic>?)
          ?.map((e) => MRoute.fromJson(e as Map<String, dynamic>))
          .toList()
      ..outletList = (json['outlets'] as List<dynamic>?)
          ?.map((e) => OutletModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..assetList = (json['assets'] as List<dynamic>?)
          ?.map((e) => Asset.fromJson(e as Map<String, dynamic>))
          .toList()
      ..distributionId = json['distributionId'] as int?
      ..employeeName = json['employeeName'] as String?
      ..configuration = json['configuration'] == null
          ? null
          : ConfigurationModel.fromJson(json['configuration'] as Map<String, dynamic>)
      ..targetVsAchievement = json['targetVSAchievement'] == null
          ? null
          : TargetVsAchievement.fromJson(json['targetVSAchievement'] as Map<String, dynamic>)
      ..systemConfiguration = json['systemConfiguration'] == null
          ? null
          : SystemConfiguration.fromJson(json['systemConfiguration'] as Map<String, dynamic>)
      ..promosAndFOC = (json['promosAndFOC'] as List<dynamic>?)
          ?.map((e) => Promotion.fromJson(e as Map<String, dynamic>))
          .toList()
      ..tasks = (json['tasks'] as List<dynamic>?)
          ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList()
      ..lookUp = json['lookup'] == null
          ? null
          : LookUpModel.fromJson(json['lookup'] as Map<String, dynamic>)
      ..orders = (json['orders'] as List<dynamic>?)
          ?.map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..deliveryDate = json['deliveryDate'] as int?
      ..organizationId = json['organizationId'] as int?
      ..warehouseId = json['warehouseId'] as int?
      ..dailyOutletStock = (json['dailyOutletStock'] as List<dynamic>?)
          ?.map((e) => AvailableStock.fromJson(e as Map<String, dynamic>))
          .toList()
      ..marketReturnDetails = (json['marketReturns'] as List<dynamic>?)
          ?.map((e) => MarketReturnDetail.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$RouteOutletResponseModelToJson(RouteOutletResponseModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'success': instance.success,
      'errorCode': instance.errorCode,
      'routes': instance.routeList?.map((e) => e.toJson()).toList(),
      'outlets': instance.outletList?.map((e) => e.toJson()).toList(),
      'assets': instance.assetList?.map((e) => e.toJson()).toList(),
      'distributionId': instance.distributionId,
      'employeeName': instance.employeeName,
      'configuration': instance.configuration?.toJson(),
      'targetVSAchievement': instance.targetVsAchievement?.toJson(),
      'systemConfiguration': instance.systemConfiguration?.toJson(),
      'promosAndFOC': instance.promosAndFOC?.map((e) => e.toJson()).toList(),
      'tasks': instance.tasks?.map((e) => e.toJson()).toList(),
      'lookup': instance.lookUp?.toJson(),
      'orders': instance.orders?.map((e) => e.toJson()).toList(),
      'deliveryDate': instance.deliveryDate,
      'organizationId': instance.organizationId,
      'warehouseId': instance.warehouseId,
      'dailyOutletStock': instance.dailyOutletStock?.map((e) => e.toJson()).toList(),
      'marketReturns': instance.marketReturnDetails?.map((e) => e.toJson()).toList(),
    };
