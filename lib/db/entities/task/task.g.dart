// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    taskId: json['taskId'] as int?,
    taskTypeId: json['taskTypeId'] as int?,
    taskName: json['taskName'] as String?,
    taskDate: json['taskDate'] as String?,
    outletId: json['outletId'] as int?,
    completedDate: json['completedDate'] as String?,
    status: json['status'] as String?,
    remarks: json['remarks'] as String?,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
  'taskId': instance.taskId,
  'taskTypeId': instance.taskTypeId,
  'taskName': instance.taskName,
  'taskDate': instance.taskDate,
  'outletId': instance.outletId,
  'completedDate': instance.completedDate,
  'status': instance.status,
  'remarks': instance.remarks,
};
