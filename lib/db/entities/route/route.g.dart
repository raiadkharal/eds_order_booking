// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

MRoute _$RouteFromJson(Map<String, dynamic> json) {
  return MRoute(
    routeId: json['routeId'] as int?,
    routeName: json['routeName'] as String?,
    employeeId: json['employeeId'] as int?,
    totalOutlets: json['totalOutlets'] as int?,
  );
}

Map<String, dynamic> _$RouteToJson(MRoute instance) => <String, dynamic>{
  'routeId': instance.routeId,
  'routeName': instance.routeName,
  'employeeId': instance.employeeId,
  'totalOutlets': instance.totalOutlets,
};
