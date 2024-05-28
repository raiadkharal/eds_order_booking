// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Package _$PackageFromJson(Map<String, dynamic> json) {
  return Package(
    packageId: json['productPackageId'] as int?,
    packageName: json['productPackageName'] as String?,
  );
}

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
  'productPackageId': instance.packageId,
  'productPackageName': instance.packageName,
};
