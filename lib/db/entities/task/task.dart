import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  @JsonKey(name: 'taskId')
  final int? taskId;

  @JsonKey(name: 'taskTypeId')
  final int? taskTypeId;

  @JsonKey(name: 'taskName')
  final String? taskName;

  @JsonKey(name: 'taskDate')
  final String? taskDate;

  @JsonKey(name: 'outletId')
  final int? outletId;

  @JsonKey(name: 'completedDate')
  final String? completedDate;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'remarks')
  final String? remarks;

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
