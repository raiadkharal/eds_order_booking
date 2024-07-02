import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable()
class TokenResponse {
  @JsonKey(name: 'access_token')
  String? accessToken;

  @JsonKey(name: 'expires_in')
  int? expiresIn;

  @JsonKey(name: 'token_type')
  String? tokenType;

  @JsonKey(name: 'success')
  bool? _success;

  @JsonKey(name: 'error_description')
  String? _errorMessage;

  TokenResponse();

  bool get isSuccess => _success ?? true;

  String? get errorMessage => _errorMessage;

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}
