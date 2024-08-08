// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchandise_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchandiseImage _$MerchandiseImageFromJson(Map<String, dynamic> json) {
  return MerchandiseImage(
    id: json['id'] as int?,
    path: json['path'] as String?,
    image: json['image'] as String?,
    type: json['type'] as int?,
    status: json['status'] as int?,
  );
}

Map<String, dynamic> _$MerchandiseImageToJson(MerchandiseImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'image': instance.image,
      'type': instance.type,
      'status': instance.status,
    };
