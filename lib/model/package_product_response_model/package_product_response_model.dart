import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/db/entities/packages/package.dart';
import 'package:order_booking/db/entities/product/product.dart';
import 'package:order_booking/db/entities/product_group/product_group.dart';
import 'package:order_booking/db/models/base_response/base_response.dart';

part 'package_product_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PackageProductResponseModel extends BaseResponse {
  @JsonKey(name: 'productPackages')
  List<Package>? packageList;

  @JsonKey(name: 'productGroups')
  List<ProductGroup>? productGroups;

  @JsonKey(name: 'products')
  List<Product>? productList;

  PackageProductResponseModel();

  factory PackageProductResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PackageProductResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PackageProductResponseModelToJson(this);
}
