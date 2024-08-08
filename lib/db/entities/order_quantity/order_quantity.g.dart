part of 'order_quantity.dart';
// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderAndAvailableQuantity _$OrderAndAvailableQuantityFromJson(Map<String, dynamic> json) {
  return OrderAndAvailableQuantity(
    outletId: json['outletId'] as int?,
    productId: json['productId'] as int?,
    cartonQuantity: json['cartonQuantity'] as int?,
    unitQuantity: json['unitQuantity'] as int?,
    avlCartonQuantity: json['avlCartonQuantity'] as int?,
    avlUnitQuantity: json['avlUnitQuantity'] as int?,
  );
}

Map<String, dynamic> _$OrderAndAvailableQuantityToJson(OrderAndAvailableQuantity instance) =>
    <String, dynamic>{
      'outletId': instance.outletId,
      'productId': instance.productId,
      'cartonQuantity': instance.cartonQuantity,
      'unitQuantity': instance.unitQuantity,
      'avlCartonQuantity': instance.avlCartonQuantity,
      'avlUnitQuantity': instance.avlUnitQuantity,
    };
