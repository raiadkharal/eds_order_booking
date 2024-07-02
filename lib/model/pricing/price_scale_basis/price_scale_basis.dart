import 'package:json_annotation/json_annotation.dart';

part 'price_scale_basis.g.dart';

@JsonSerializable()
class PriceScaleBasis {
  @JsonKey(name: 'priceScaleBasisId')
  final int? priceScaleBasisId;

  final String? value;

  PriceScaleBasis({
    required this.priceScaleBasisId,
    this.value,
  });


  factory PriceScaleBasis.fromJson(Map<String, dynamic> json) => _$PriceScaleBasisFromJson(json);

  Map<String, dynamic> toJson() => _$PriceScaleBasisToJson(this);
}
