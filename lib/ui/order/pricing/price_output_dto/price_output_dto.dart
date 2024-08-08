import 'package:json_annotation/json_annotation.dart';
import '../../../../db/entities/unit_price_breakdown/unit_price_breakdown.dart';
import '../message/message.dart';

part 'price_output_dto.g.dart';

@JsonSerializable()
class PriceOutputDTO {
  @JsonKey(name: 'TotalPrice')
  double? totalPrice;

  @JsonKey(name: 'PriceBreakdown')
  List<UnitPriceBreakDown>? priceBreakdown;

  @JsonKey(name: 'Messages')
  List<Message>? messages;

  PriceOutputDTO({
    this.totalPrice,
    this.priceBreakdown,
    this.messages,
  });

  factory PriceOutputDTO.fromJson(Map<String, dynamic> json) => _$PriceOutputDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PriceOutputDTOToJson(this);
}
