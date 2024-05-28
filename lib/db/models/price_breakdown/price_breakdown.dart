import '../../entities/unit_price_breakdown/unit_price_breakdown.dart';

class PriceBreakDown extends UnitPriceBreakDown {

  PriceBreakDown(int _priceConditionId,String _priceConditionType){
   priceConditionId = _priceConditionId;
   priceConditionType=_priceConditionType;
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
    if(priceConditionId!=null) {
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
}
