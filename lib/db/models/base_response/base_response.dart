import 'dart:async';

import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'success',includeIfNull: false)
  String? _success;
  @JsonKey(name: 'errorMessage',includeIfNull: false)
  String? errorMessage;
  @JsonKey(name: 'errorCode',includeIfNull: false)
  int? _errorCode;

  BaseResponse([this._success]);

  BaseResponse.success(this._success);

  BaseResponse.withDetails(this._success, this.errorMessage, this._errorCode);

  String? get success => _success;

  set success(String? value) {
    _success = value;
  }

  int? get errorCode => _errorCode;

  set errorCode(int? value) {
    _errorCode = value;
  }

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
