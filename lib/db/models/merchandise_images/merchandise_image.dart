import 'package:json_annotation/json_annotation.dart';

part 'merchandise_image.g.dart';

@JsonSerializable()
class MerchandiseImage {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'path')
  final String path;

  @JsonKey(name: 'image')
  final String image;

  @JsonKey(name: 'type')
  final int type;

  @JsonKey(name: 'status')
  final int status;

  MerchandiseImage({
    required this.id,
    required this.path,
    required this.image,
    required this.type,
    required this.status,
  });

  factory MerchandiseImage.fromJson(Map<String, dynamic> json) =>
      _$MerchandiseImageFromJson(json);

  Map<String, dynamic> toJson() => _$MerchandiseImageToJson(this);
}
