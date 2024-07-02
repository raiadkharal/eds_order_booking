import 'package:json_annotation/json_annotation.dart';

part 'work_status.g.dart';

@JsonSerializable()
class WorkStatus {
  @JsonKey(name: 'syncDate')
  int? _syncDate;

  @JsonKey(name: 'dayStarted')
  int? _dayStarted;

  WorkStatus(int dayStarted){
   _dayStarted=dayStarted;
  }

  int get syncDate => _syncDate ?? 0;

  set syncDate(int value) {
    _syncDate = value;
  }

  int get dayStarted => _dayStarted ?? 0;

  set dayStarted(int value) {
    _dayStarted = value;
  }

  bool get isDayStarted => dayStarted == 1;

  factory WorkStatus.fromJson(Map<String, dynamic> json) =>
      _$WorkStatusFromJson(json);

  Map<String, dynamic> toJson() => _$WorkStatusToJson(this);
}
