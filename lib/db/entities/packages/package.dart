import 'package:json_annotation/json_annotation.dart';

part 'package.g.dart';

@JsonSerializable()
class Package {
  @JsonKey(name: 'productPackageId')
  final int? packageId;
  @JsonKey(name: 'productPackageName')
  final String? packageName;

  Package({
    this.packageId,
    this.packageName,
  });

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);

  Map<String, dynamic> toJson() => _$PackageToJson(this);
}
