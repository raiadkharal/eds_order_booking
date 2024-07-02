// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_product_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageProductResponseModel _$PackageProductResponseModelFromJson(
        Map<String, dynamic> json) =>
    PackageProductResponseModel()
      ..errorMessage = json['errorMessage'] as String?
      ..success = json['success'] as String?
      ..errorCode = json['errorCode'] as int?
      ..packageList = (json['productPackages'] as List<dynamic>?)
          ?.map((e) => Package.fromJson(e as Map<String, dynamic>))
          .toList()
      ..productGroups = (json['productGroups'] as List<dynamic>?)
          ?.map((e) => ProductGroup.fromJson(e as Map<String, dynamic>))
          .toList()
      ..productList = (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$PackageProductResponseModelToJson(
        PackageProductResponseModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'success': instance.success,
      'errorCode': instance.errorCode,
      'productPackages': instance.packageList?.map((e) => e.toJson()).toList(),
      'productGroups': instance.productGroups?.map((e) => e.toJson()).toList(),
      'products': instance.productList?.map((e) => e.toJson()).toList(),
    };
