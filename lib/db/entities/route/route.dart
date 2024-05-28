import 'package:json_annotation/json_annotation.dart';

part 'route.g.dart';

@JsonSerializable()
class Route {
  @JsonKey(name: 'routeId')
  int? routeId;

  @JsonKey(name: 'routeName')
  String? routeName;

  @JsonKey(name: 'employeeId')
  int? employeeId;

  @JsonKey(name: 'totalOutlets')
  int? totalOutlets;

  Route({
    this.routeId,
    this.routeName,
    this.employeeId,
    this.totalOutlets,
  });

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);

  Map<String, dynamic> toJson() => _$RouteToJson(this);
}
