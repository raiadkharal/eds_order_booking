import 'package:json_annotation/json_annotation.dart';

part 'free_good_entity_details.g.dart';

@JsonSerializable()
class FreeGoodEntityDetails {
  @JsonKey(name: 'freeGoodEntityDetailId')
  final int freeGoodEntityDetailId;

  @JsonKey(name: 'freeGoodMasterId')
  final int freeGoodMasterId;

  @JsonKey(name: 'outletId')
  final int outletId;

  @JsonKey(name: 'routeId')
  final int routeId;

  @JsonKey(name: 'distributionId')
  final int distributionId;

  @JsonKey(name: 'channelId')
  final int channelId;

  @JsonKey(name: 'entityCode')
  final String entityCode;

  @JsonKey(name: 'entityText')
  final String entityText;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'location')
  final String location;

  @JsonKey(name: 'address')
  final String address;

  @JsonKey(name: 'channel')
  final String channel;

  FreeGoodEntityDetails({
    required this.freeGoodEntityDetailId,
    required this.freeGoodMasterId,
    required this.outletId,
    required this.routeId,
    required this.distributionId,
    required this.channelId,
    required this.entityCode,
    required this.entityText,
    required this.status,
    required this.location,
    required this.address,
    required this.channel,
  });

  factory FreeGoodEntityDetails.fromJson(Map<String, dynamic> json) =>
      _$FreeGoodEntityDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$FreeGoodEntityDetailsToJson(this);
}
