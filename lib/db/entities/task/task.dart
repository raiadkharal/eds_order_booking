import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  @JsonKey(name: 'taskId')
  int? taskId;

  @JsonKey(name: 'taskTypeId')
  int? taskTypeId;

  @JsonKey(name: 'taskName')
  String? taskName;

  @JsonKey(name: 'taskDate')
  String? taskDate;

  @JsonKey(name: 'outletId')
  int? outletId;

  @JsonKey(name: 'completedDate')
  String? completedDate;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'remarks')
  String? remarks;

  Task({
    required this.taskId,
    required this.taskTypeId,
    this.taskName,
    this.taskDate,
    this.outletId,
    this.completedDate,
    this.status,
    this.remarks,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
