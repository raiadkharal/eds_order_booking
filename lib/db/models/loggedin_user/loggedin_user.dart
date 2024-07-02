import 'package:json_annotation/json_annotation.dart';

part 'loggedin_user.g.dart';

@JsonSerializable()
class LoggedInUser {
  @JsonKey(name: 'password')
  String? _password;

  @JsonKey(name: 'displayName')
  String? _displayName;

  @JsonKey(name: 'token')
  String? _token;

  LoggedInUser(String displayName, String password, String token)
      : _displayName = displayName,
        _password = password,
        _token = token;

  String? get displayName => _displayName;

  set displayName(String? value) {
    _displayName = value;
  }

  String? get token => _token;

  set token(String? value) {
    _token = value;
  }

  String? get password => _password;

  set password(String? value) {
    _password = value;
  }

  factory LoggedInUser.fromJson(Map<String, dynamic> json) =>
      _$LoggedInUserFromJson(json);

  Map<String, dynamic> toJson() => _$LoggedInUserToJson(this);
}
