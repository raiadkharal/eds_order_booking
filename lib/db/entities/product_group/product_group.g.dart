// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_group.dart';

ProductGroup _$ProductGroupFromJson(Map<String, dynamic> json) {
  return ProductGroup(
    productGroupId: json['productGroupId'] as int?,
    productGroupName: json['productGroupName'] as String?,
  );
}

Map<String, dynamic> _$ProductGroupToJson(ProductGroup instance) =>
    <String, dynamic>{
      'productGroupId': instance.productGroupId,
      'productGroupName': instance.productGroupName,
    };
