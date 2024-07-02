import 'package:json_annotation/json_annotation.dart';

part 'merchandise_image.g.dart';

@JsonSerializable()
class MerchandiseImage {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'path')
  String? path;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'type')
  int? type;

  @JsonKey(name: 'status')
  int? status;

  MerchandiseImage({
    this.id,
    this.path,
    this.image,
    this.type,
    this.status,
  });

  factory MerchandiseImage.fromJson(Map<String, dynamic> json) =>
      _$MerchandiseImageFromJson(json);

  Map<String, dynamic> toJson() => _$MerchandiseImageToJson(this);
}
