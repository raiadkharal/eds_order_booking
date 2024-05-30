part of 'free_goods_wrapper.dart';

FreeGoodsWrapper _$FreeGoodsWrapperFromJson(Map<String, dynamic> json) {
  return FreeGoodsWrapper(
    freeGoodMasters: (jsonDecode(json['freeGoodMasters']) as List<dynamic>?)
        ?.map((e) => FreeGoodMasters.fromJson(e as Map<String, dynamic>))
        .toList(),
    freeGoodGroups: (jsonDecode(json['freeGoodGroups']) as List<dynamic>?)
        ?.map((e) => FreeGoodGroups.fromJson(e as Map<String, dynamic>))
        .toList(),
    priceConditionOutletAttributes: (jsonDecode(json['priceConditionOutletAttributes']) as List<dynamic>?)
        ?.map((e) => FreePriceConditionOutletAttributes.fromJson(e as Map<String, dynamic>))
        .toList(),
    freeGoodDetails: (jsonDecode(json['freeGoodDetails']) as List<dynamic>?)
        ?.map((e) => FreeGoodDetails.fromJson(e as Map<String, dynamic>))
        .toList(),
    freeGoodExclusives: (jsonDecode(json['freeGoodExclusives']) as List<dynamic>?)
        ?.map((e) => FreeGoodExclusives.fromJson(e as Map<String, dynamic>))
        .toList(),
    freeGoodEntityDetails: (jsonDecode(json['freeGoodEntityDetails']) as List<dynamic>?)
        ?.map((e) => FreeGoodEntityDetails.fromJson(e as Map<String, dynamic>))
        .toList(),
    outletAvailedFreeGoods: (jsonDecode(json['outletAvailedFreeGoods']) as List<dynamic>?)
        ?.map((e) => OutletAvailedFreeGoods.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FreeGoodsWrapperToJson(FreeGoodsWrapper instance) => <String, dynamic>{
  'freeGoodMasters': jsonEncode(instance.freeGoodMasters),
  'freeGoodGroups': jsonEncode(instance.freeGoodGroups),
  'priceConditionOutletAttributes': jsonEncode(instance.priceConditionOutletAttributes),
  'freeGoodDetails': jsonEncode(instance.freeGoodDetails),
  'freeGoodExclusives': jsonEncode(instance.freeGoodExclusives),
  'freeGoodEntityDetails': jsonEncode(instance.freeGoodEntityDetails),
  'outletAvailedFreeGoods': jsonEncode(instance.outletAvailedFreeGoods),
};
