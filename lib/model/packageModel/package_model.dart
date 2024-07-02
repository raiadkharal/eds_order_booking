import 'package:json_annotation/json_annotation.dart';

import '../../db/entities/product/product.dart';

part 'package_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PackageModel {
  final List<Product>? products;
  final int? packageId;
  final String? packageName;

  PackageModel({
    this.products,
    this.packageId,
    this.packageName,
  });

  // Factory method to create an instance from JSON
  factory PackageModel.fromJson(Map<String, dynamic> json) =>
      _$PackageModelFromJson(json);

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() => _$PackageModelToJson(this);
}
