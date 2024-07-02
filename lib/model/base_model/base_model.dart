import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable()
class BaseModel {
  @JsonKey(name: 'success')
  bool? success;

  BaseModel({this.success});

  // Factory method to generate an instance from a JSON map
  factory BaseModel.fromJson(Map<String, dynamic> json) => _$BaseModelFromJson(json);

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}
