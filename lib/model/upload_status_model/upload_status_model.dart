import 'package:json_annotation/json_annotation.dart';

part 'upload_status_model.g.dart';

@JsonSerializable()
class UploadStatusModel {
  int? outletId;
  String? outletName;
  int? synced;
  int? imageStatus;
  int? requestStatus;

  UploadStatusModel({
    required this.outletId,
    required this.outletName,
    required this.synced,
    this.imageStatus = 0,
    this.requestStatus = 0,
  });

  // Factory constructor for creating a new instance from a map
  factory UploadStatusModel.fromJson(Map<String, dynamic> json) => _$UploadStatusModelFromJson(json);

  // Method for converting an instance to a map
  Map<String, dynamic> toJson() => _$UploadStatusModelToJson(this);
}
