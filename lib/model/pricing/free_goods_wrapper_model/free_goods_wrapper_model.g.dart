part of 'free_goods_wrapper_model.dart';

FreeGoodsWrapperModel _$FreeGoodsWrapperFromJson(Map<String, dynamic> json) {
  return FreeGoodsWrapperModel(
    freeGoodMasters: ((json['freeGoodMasters']) as List<dynamic>?)
        ?.map((e) => FreeGoodMastersModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    freeGoodGroups: ((json['freeGoodGroups']) as List<dynamic>?)
        ?.map((e) => FreeGoodGroupsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    priceConditionOutletAttributes: ((json['priceConditionOutletAttributes']) as List<dynamic>?)
        ?.map((e) => FreePriceConditionOutletAttributes.fromJson(e as Map<String, dynamic>))
        .toList(),
    freeGoodDetails: ((json['freeGoodDetails']) as List<dynamic>?)
        ?.map((e) => FreeGoodDetailsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    freeGoodExclusives: ((json['freeGoodExclusives']) as List<dynamic>?)
        ?.map((e) => FreeGoodExclusivesModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    freeGoodEntityDetails: ((json['freeGoodEntityDetails']) as List<dynamic>?)
        ?.map((e) => FreeGoodEntityDetails.fromJson(e as Map<String, dynamic>))
        .toList(),
    outletAvailedFreeGoods: ((json['outletAvailedFreeGoods']) as List<dynamic>?)
        ?.map((e) => OutletAvailedFreeGoods.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FreeGoodsWrapperToJson(FreeGoodsWrapperModel instance) => <String, dynamic>{
  'freeGoodMasters': jsonEncode(instance.freeGoodMasters),
  'freeGoodGroups': jsonEncode(instance.freeGoodGroups),
  'priceConditionOutletAttributes': (instance.priceConditionOutletAttributes),
  'freeGoodDetails': jsonEncode(instance.freeGoodDetails),
  'freeGoodExclusives': jsonEncode(instance.freeGoodExclusives),
  'freeGoodEntityDetails':jsonEncode (instance.freeGoodEntityDetails),
  'outletAvailedFreeGoods': jsonEncode(instance.outletAvailedFreeGoods),
};
