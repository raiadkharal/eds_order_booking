// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loggedin_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoggedInUser _$LoggedInUserFromJson(Map<String, dynamic> json) => LoggedInUser(
      json['displayName'] as String,
      json['password'] as String,
      json['token'] as String,
    );

Map<String, dynamic> _$LoggedInUserToJson(LoggedInUser instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'token': instance.token,
      'password': instance.password,
    };
