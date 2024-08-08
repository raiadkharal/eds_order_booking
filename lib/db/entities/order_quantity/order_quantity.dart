part 'order_quantity.g.dart';

class OrderAndAvailableQuantity {
  int? outletId;
  int? productId;
  int? cartonQuantity;
  int? unitQuantity;
  int? avlCartonQuantity;
  int? avlUnitQuantity;

  OrderAndAvailableQuantity(
      {this.outletId,
      this.productId,
      this.cartonQuantity,
      this.unitQuantity,
      this.avlUnitQuantity,
      this.avlCartonQuantity});

  void setAvlQuantity(int? carton,int? unit){
    avlCartonQuantity=carton;
    avlUnitQuantity=unit;
  }

  void setOrderQuantity(int? carton,int? unit){
    cartonQuantity=carton;
    unitQuantity=unit;
  }

  factory OrderAndAvailableQuantity.fromJson(Map<String, dynamic> json) =>
      _$OrderAndAvailableQuantityFromJson(json);

  Map<String, dynamic> toJson() => _$OrderAndAvailableQuantityToJson(this);

}
