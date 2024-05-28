import 'package:json_annotation/json_annotation.dart';

part 'product_group.g.dart';

@JsonSerializable()
class ProductGroup {
  @JsonKey(name: 'productGroupId')
  final int? productGroupId;

  @JsonKey(name: 'productGroupName')
  final String? productGroupName;

  ProductGroup({
    this.productGroupId,
    this.productGroupName,
  });

  factory ProductGroup.fromJson(Map<String, dynamic> json) =>
      _$ProductGroupFromJson(json);

  Map<String, dynamic> toJson() => _$ProductGroupToJson(this);
}
