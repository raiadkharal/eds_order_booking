import 'package:json_annotation/json_annotation.dart';

part 'app_update_model.g.dart';

@JsonSerializable()
class AppUpdateModel {
  final String? file;
  final int? version;
  final int? date;

  @JsonKey(name: 'error_msg')
  final String? msg;

  AppUpdateModel({
    this.file,
    this.version,
    this.date,
    this.msg,
  });

  factory AppUpdateModel.fromJson(Map<String, dynamic> json) => _$AppUpdateModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppUpdateModelToJson(this);
}
