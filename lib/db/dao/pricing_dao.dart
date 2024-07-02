import 'package:order_booking/db/entities/outlet_availed_promotion/outlet_availed_promotion.dart';
import 'package:order_booking/db/entities/pricing/price_access_sequence/price_access_sequence.dart';
import 'package:order_booking/db/entities/pricing/price_condition_outlet_arribute/price_condition_outlet_attribute.dart';
import 'package:order_booking/model/pricing/free_price_condition_outlet_attributes/free_price_condition_outlet_attributes.dart';
import 'package:order_booking/model/pricing/outlet_availed_free_goods/outlet_availed_free_goods.dart';
import 'package:order_booking/model/pricing/price_bundle/price_bundle.dart';

import '../entities/pricing/free_good_exclusives/free_goods_exclusives.dart';
import '../entities/pricing/free_good_groups/free_good_groups.dart';
import '../entities/pricing/free_good_masters/free_good_masters.dart';
import '../entities/pricing/free_goods_detail/free_goods_detail.dart';
import '../entities/pricing/free_goods_entity_details/free_good_entity_details.dart';
import '../entities/pricing/price_condition/price_condition.dart';
import '../entities/pricing/price_condition_class/price_condition_class.dart';
import '../entities/pricing/price_condition_detail/price_condition_detail.dart';
import '../entities/pricing/price_condition_entities/price_condition_entities.dart';
import '../entities/pricing/price_condition_scale/price_condition_scale.dart';
import '../entities/pricing/price_condition_type/price_condition_type.dart';

abstract class PricingDao {
  Future<void> deleteAllPriceConditionClasses();

  Future<void> deleteAllPriceConditionEntities();
  Future<void> deleteAllPriceBundles();

  Future<void> deleteAllPricingAreas();

  Future<void> deleteAllTempQty();

  Future<void> deletePriceConditionTypes();

  Future<void> deletePriceAccessSequence();

  Future<void> deletePriceCondition();

  Future<void> deletePriceConditionDetail();


  Future<void> deletePriceConditionEntity();


  Future<void> deletePriceConditionScale();


  Future<void> deletePriceConditionOutletAttribute();


  Future<void> deleteFreeGoodMasters();

  Future<void> deleteFreeGoodGroups();

  Future<void> deleteFreePriceConditionOutletAttribute();

  Future<void> deleteFreeGoodDetails();

  Future<void> deleteFreeGoodExclusives();

  Future<void> deleteFreeGoodEntityDetails();

  Future<void> deleteOutletAvailedFreeGoods();

  Future<void> deleteOutletAvailedPromotion();

  Future<void> insertPriceConditionClasses(List<PriceConditionClass>? priceConditionClasses);

  Future<void> insertPriceConditionType(List<PriceConditionType>? priceConditionTypes);

  Future<void> insertPriceAccessSequence(List<PriceAccessSequence>? priceAccessSequences);

  Future<void> insertPriceCondition(List<PriceCondition>? priceConditions);

  Future<void> insertPriceBundles(List<PriceBundle>? priceBundles);

  Future<void> insertPriceConditionDetail(List<PriceConditionDetail>? priceConditionDetails);

  Future<void> insertPriceConditionEntities(List<PriceConditionEntities>? priceConditionEntities);

  Future<void> insertPriceConditionScales(List<PriceConditionScale>? priceConditionScales);

  Future<void> insertPriceConditionOutletAttributes(List<PriceConditionOutletAttribute>? priceConditionOutletAttributes);

  Future<void> insertOutletAvailedPromotions(List<OutletAvailedPromotion>? outletAvailedPromotions);

  Future<void> insertFreeGoodMasters(List<FreeGoodMasters>? freeGoodMasters);

  Future<void> insertFreeGoodGroups(List<FreeGoodGroups>? freeGoodGroups);

  Future<void> insertFreePriceConditionOutletAttributes(List<FreePriceConditionOutletAttributes>? priceConditionOutletAttributes);

  Future<void> insertFreeGoodDetails(List<FreeGoodDetails>? freeGoodDetails);

  Future<void> insertFreeGoodExclusives(List<FreeGoodExclusives>? freeGoodExclusives);

  Future<void> insertFreeGoodEntityDetails(List<FreeGoodEntityDetails>? freeGoodEntityDetails);

  Future<void> insertOutletAvailedFreeGoods(List<OutletAvailedFreeGoods>? outletAvailedFreeGoods);

}
