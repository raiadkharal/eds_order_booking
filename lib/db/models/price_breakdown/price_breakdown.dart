import 'package:json_annotation/json_annotation.dart';
import '../../../utils/utils.dart';
import '../../entities/unit_price_breakdown/unit_price_breakdown.dart';

part 'price_breakdown.g.dart';

@JsonSerializable()
class PriceBreakDown extends UnitPriceBreakDown {
  PriceBreakDown(int priceConditionId, String priceConditionType) {
    this.priceConditionId = priceConditionId;
    this.priceConditionType = priceConditionType;
  }

  int? getPriceConditionClassOrder() {
    if (priceConditionClassOrder == null || priceConditionClassOrder! < 1) {
      return priceConditionId;
    }
    return priceConditionClassOrder!;
  }

  @override
  int get hashCode {
    const prime = 31;
    var result = 1;
    if (priceConditionId != null) {
      result = prime * result + priceConditionId!;
    }
    return result;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final PriceBreakDown otherPriceBreakDown = other as PriceBreakDown;
    return priceConditionId == otherPriceBreakDown.priceConditionId;
  }

  factory PriceBreakDown.fromJson(Map<String, dynamic> json) => _$PriceBreakDownFromJson(json);

  Map<String, dynamic> toJson() => _$PriceBreakDownToJson(this);
}
