import 'package:json_annotation/json_annotation.dart';
import 'package:order_booking/model/pricing/price_condition_class_model/price_condition_class.dart';
import 'package:order_booking/model/pricing/price_condition_detail_model/price_condition_detail_model.dart';
import 'package:order_booking/model/pricing/price_condition_entities_model/price_condition_entities_model.dart';
import 'package:order_booking/model/pricing/price_condition_model/price_condition_model.dart';

import '../../db/entities/outlet_availed_promotion/outlet_availed_promotion.dart';
import '../../db/entities/pricing/price_access_sequence/price_access_sequence.dart';
import '../../db/entities/pricing/price_condition_outlet_arribute/price_condition_outlet_attribute.dart';
import '../../db/entities/pricing/price_condition_scale/price_condition_scale.dart';
import '../base_model/base_model.dart';
import '../pricing/free_goods_wrapper_model/free_goods_wrapper_model.dart';
import '../pricing/price_bundle/price_bundle.dart';
import '../pricing/price_condition_type_model/price_condition_type_model.dart';

part 'pricing_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PricingModel extends BaseModel {
  @JsonKey(name: 'priceConditionClass')
  List<PriceConditionClassModel> priceConditionClasses;

  @JsonKey(name: 'priceConditionType')
  List<PriceConditionTypeModel> priceConditionTypes;

  @JsonKey(name: 'priceCondition')
  List<PriceConditionModel> priceConditions;

  @JsonKey(name: 'priceBundle')
  List<PriceBundle> priceBundles;

  @JsonKey(name: 'priceConditionEntity')
  List<PriceConditionEntitiesModel> priceConditionEntities;

  @JsonKey(name: 'priceConditionDetail')
  List<PriceConditionDetailModel> priceConditionDetails;

  @JsonKey(name: 'priceConditionScale')
  List<PriceConditionScale> priceConditionScales;

  @JsonKey(name: 'priceAccessSequence')
  List<PriceAccessSequence> priceAccessSequences;

  @JsonKey(name: 'outletAvailedPromotions')
  List<OutletAvailedPromotion> outletAvailedPromotions;

  @JsonKey(name: 'priceConditionOutletAttribute')
  List<PriceConditionOutletAttribute> priceConditionOutletAttributes;

  @JsonKey(name: 'freeGoodsWrapper')
  FreeGoodsWrapperModel? freeGoodsWrapper;

  PricingModel({
    this.priceConditionClasses = const [],
    this.priceConditionTypes = const [],
    this.priceConditions = const [],
    this.priceBundles = const [],
    this.priceConditionEntities = const [],
    this.priceConditionDetails = const [],
    this.priceConditionScales = const [],
    this.priceAccessSequences = const [],
    this.outletAvailedPromotions = const [],
    this.priceConditionOutletAttributes = const [],
    this.freeGoodsWrapper,
  });

  factory PricingModel.fromJson(Map<String, dynamic> json) => _$PricingModelFromJson(json);

  Map<String, dynamic> toJson() => _$PricingModelToJson(this);
}
