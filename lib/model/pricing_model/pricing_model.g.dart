// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricingModel _$PricingModelFromJson(Map<String, dynamic> json) => PricingModel(
  priceConditionClasses: (json['priceConditionClass'] as List<dynamic>?)
      ?.map((e) => PriceConditionClassModel.fromJson(e as Map<String, dynamic>))
      .toList() ?? [],
  priceConditionTypes: (json['priceConditionType'] as List<dynamic>?)
      ?.map((e) => PriceConditionTypeModel.fromJson(e as Map<String, dynamic>))
      .toList() ?? [],
  priceConditions: (json['priceCondition'] as List<dynamic>?)
      ?.map((e) => PriceConditionModel.fromJson(e as Map<String, dynamic>))
      .toList() ?? [],
  priceBundles: (json['priceBundle'] as List<dynamic>?)
      ?.map((e) => PriceBundle.fromJson(e as Map<String, dynamic>))
      .toList() ?? [],
  priceConditionEntities: (json['priceConditionEntity'] as List<dynamic>?)
      ?.map((e) => PriceConditionEntitiesModel.fromJson(e as Map<String, dynamic>))
      .toList() ?? [],
  priceConditionDetails: (json['priceConditionDetail'] as List<dynamic>?)
      ?.map((e) => PriceConditionDetailModel.fromJson(e as Map<String, dynamic>))
      .toList() ?? [],
  priceConditionScales: (json['priceConditionScale'] as List<dynamic>?)
      ?.map((e) => PriceConditionScale.fromJson(e as Map<String, dynamic>))
      .toList() ?? [],
  priceAccessSequences: (json['priceAccessSequence'] as List<dynamic>?)
      ?.map((e) => PriceAccessSequence.fromJson(e as Map<String, dynamic>))
      .toList() ?? [],
  outletAvailedPromotions: (json['outletAvailedPromotions'] as List<dynamic>?)
      ?.map((e) => OutletAvailedPromotion.fromJson(e as Map<String, dynamic>))
      .toList() ?? [],
  priceConditionOutletAttributes: (json['priceConditionOutletAttribute'] as List<dynamic>?)
      ?.map((e) => PriceConditionOutletAttribute.fromJson(e as Map<String, dynamic>))
      .toList() ?? [],
  freeGoodsWrapper: json['freeGoodsWrapper'] == null
      ? null
      : FreeGoodsWrapperModel.fromJson(json['freeGoodsWrapper'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PricingModelToJson(PricingModel instance) => <String, dynamic>{
  'priceConditionClass': instance.priceConditionClasses.map((e) => e.toJson()).toList(),
  'priceConditionType': instance.priceConditionTypes.map((e) => e.toJson()).toList(),
  'priceCondition': instance.priceConditions.map((e) => e.toJson()).toList(),
  'priceBundle': instance.priceBundles.map((e) => e.toJson()).toList(),
  'priceConditionEntity': instance.priceConditionEntities.map((e) => e.toJson()).toList(),
  'priceConditionDetail': instance.priceConditionDetails.map((e) => e.toJson()).toList(),
  'priceConditionScale': instance.priceConditionScales.map((e) => e.toJson()).toList(),
  'priceAccessSequence': instance.priceAccessSequences.map((e) => e.toJson()).toList(),
  'outletAvailedPromotions': instance.outletAvailedPromotions.map((e) => e.toJson()).toList(),
  'priceConditionOutletAttribute': instance.priceConditionOutletAttributes.map((e) => e.toJson()).toList(),
  'freeGoodsWrapper': instance.freeGoodsWrapper?.toJson(),
};
