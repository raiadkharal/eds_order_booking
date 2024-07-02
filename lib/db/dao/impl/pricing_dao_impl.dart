import 'package:order_booking/db/dao/pricing_dao.dart';
import 'package:order_booking/db/entities/outlet_availed_promotion/outlet_availed_promotion.dart';
import 'package:order_booking/db/entities/pricing/price_condition_outlet_arribute/price_condition_outlet_attribute.dart';
import 'package:order_booking/model/pricing/free_price_condition_outlet_attributes/free_price_condition_outlet_attributes.dart';
import 'package:order_booking/model/pricing/outlet_availed_free_goods/outlet_availed_free_goods.dart';
import 'package:order_booking/model/pricing/price_bundle/price_bundle.dart';
import 'package:sqflite/sqflite.dart';

import '../../entities/pricing/free_good_exclusives/free_goods_exclusives.dart';
import '../../entities/pricing/free_good_groups/free_good_groups.dart';
import '../../entities/pricing/free_good_masters/free_good_masters.dart';
import '../../entities/pricing/free_goods_detail/free_goods_detail.dart';
import '../../entities/pricing/free_goods_entity_details/free_good_entity_details.dart';
import '../../entities/pricing/price_access_sequence/price_access_sequence.dart';
import '../../entities/pricing/price_condition/price_condition.dart';
import '../../entities/pricing/price_condition_class/price_condition_class.dart';
import '../../entities/pricing/price_condition_detail/price_condition_detail.dart';
import '../../entities/pricing/price_condition_entities/price_condition_entities.dart';
import '../../entities/pricing/price_condition_scale/price_condition_scale.dart';
import '../../entities/pricing/price_condition_type/price_condition_type.dart';

class PricingDaoImpl extends PricingDao {
  final Database _database;

  PricingDaoImpl(this._database);

  @override
  Future<void> deleteAllPriceConditionClasses() async {
    _database.rawQuery("DELETE FROM PriceConditionClass");
  }

  @override
  Future<void> deleteAllPriceBundles() async {
    _database.rawQuery("DELETE FROM PriceBundle");
  }

  @override
  Future<void> deleteAllPricingAreas() async {
    _database.rawQuery("DELETE FROM PricingArea");
  }

  @override
  Future<void> deleteAllTempQty() async {
    _database.rawQuery("DELETE FROM ProductQuantity");
  }

  @override
  Future<void> deleteFreeGoodDetails() async {
    _database.rawQuery("DELETE FROM FreeGoodDetails");
  }

  @override
  Future<void> deleteFreeGoodEntityDetails() async {
    _database.rawQuery("DELETE FROM FreeGoodEntityDetails");
  }

  @override
  Future<void> deleteFreeGoodExclusives() async {
    _database.rawQuery("DELETE FROM FreeGoodExclusives");
  }

  @override
  Future<void> deleteFreeGoodGroups() async {
    _database.rawQuery("DELETE FROM FreeGoodGroups");
  }

  @override
  Future<void> deleteFreeGoodMasters() async {
    _database.rawQuery("DELETE FROM FreeGoodMasters");
  }

  @override
  Future<void> deleteFreePriceConditionOutletAttribute() async {
    _database.rawQuery("DELETE FROM FreePriceConditionOutletAttributes");
  }

  @override
  Future<void> deleteOutletAvailedFreeGoods() async {
    _database.rawQuery("DELETE FROM OutletAvailedFreeGoods");
  }

  @override
  Future<void> deleteOutletAvailedPromotion() async {
    _database.rawQuery("DELETE FROM OutletAvailedPromotion");
  }

  @override
  Future<void> deletePriceAccessSequence() async {
    _database.rawQuery("DELETE FROM PriceAccessSequence");
  }

  @override
  Future<void> deletePriceCondition() async {
    _database.rawQuery("DELETE FROM PriceCondition");
  }

  @override
  Future<void> deletePriceConditionDetail() async {
    _database.rawQuery("DELETE FROM PriceConditionDetail");
  }

  @override
  Future<void> deletePriceConditionEntity() async {
    _database.rawQuery("DELETE FROM PriceConditionEntities");
  }

  @override
  Future<void> deletePriceConditionOutletAttribute() async {
    _database.rawQuery("DELETE FROM PriceConditionOutletAttribute");
  }

  @override
  Future<void> deletePriceConditionScale() async {
    _database.rawQuery("DELETE FROM PriceConditionScale");
  }

  @override
  Future<void> deletePriceConditionTypes() async {
    _database.rawQuery("DELETE FROM PriceConditionType");
  }

  @override
  Future<void> deleteAllPriceConditionEntities() async{
    _database.rawQuery("DELETE FROM PriceConditionEntities");
  }

  @override
  Future<void> insertOutletAvailedPromotions(List<OutletAvailedPromotion>? outletAvailedPromotions) async{
    if (outletAvailedPromotions != null) {
      for (OutletAvailedPromotion outletPromotion in outletAvailedPromotions) {
        _database.insert("OutletAvailedPromotion", outletPromotion.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertPriceAccessSequence(List<PriceAccessSequence>? priceAccessSequences) async{
    if (priceAccessSequences != null) {
      for (PriceAccessSequence priceAccessSequence in priceAccessSequences) {
        _database.insert("PriceAccessSequence", priceAccessSequence.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertPriceBundles(List<PriceBundle>? priceBundles) async{
    if (priceBundles != null) {
      for (PriceBundle priceBundle in priceBundles) {
        _database.insert("PriceBundle", priceBundle.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertPriceCondition(List<PriceCondition>? priceConditions) async{
    if (priceConditions != null) {
      for (PriceCondition priceCondition in priceConditions) {
        _database.insert("PriceCondition", priceCondition.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertPriceConditionClasses(List<PriceConditionClass>? priceConditionClasses)async {
    if (priceConditionClasses != null) {
      for (PriceConditionClass priceConditionClass in priceConditionClasses) {
        _database.insert("PriceConditionClass", priceConditionClass.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertPriceConditionDetail(List<PriceConditionDetail>? priceConditionDetails)async{
    if (priceConditionDetails != null) {
      for (PriceConditionDetail priceConditionDetail in priceConditionDetails) {
        _database.insert("PriceConditionDetail", priceConditionDetail.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertPriceConditionEntities(List<PriceConditionEntities>? priceConditionEntities)async {
    if (priceConditionEntities != null) {
      for (PriceConditionEntities priceConditionEntity in priceConditionEntities) {
        _database.insert("PriceConditionEntities", priceConditionEntity.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertPriceConditionOutletAttributes(List<PriceConditionOutletAttribute>? priceConditionOutletAttributes) async{
    if (priceConditionOutletAttributes != null) {
      for (PriceConditionOutletAttribute priceConditionOutletAttribute in priceConditionOutletAttributes) {
        _database.insert("PriceConditionOutletAttribute", priceConditionOutletAttribute.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertPriceConditionScales(List<PriceConditionScale>? priceConditionScales)async {
    if (priceConditionScales != null) {
      for (PriceConditionScale priceConditionScale in priceConditionScales) {
        _database.insert("PriceConditionScale", priceConditionScale.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertPriceConditionType(List<PriceConditionType>? priceConditionTypes) async{
    if (priceConditionTypes != null) {
      for (PriceConditionType priceConditionType in priceConditionTypes) {
        _database.insert("PriceConditionType", priceConditionType.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertFreeGoodDetails(List<FreeGoodDetails>? freeGoodDetails) async{
    if (freeGoodDetails != null) {
      for (FreeGoodDetails freeGoodDetail in freeGoodDetails) {
        _database.insert("FreeGoodDetails", freeGoodDetail.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertFreeGoodEntityDetails(List<FreeGoodEntityDetails>? freeGoodEntityDetails) async{
    if (freeGoodEntityDetails != null) {
      for (FreeGoodEntityDetails freeGoodEntityDetail in freeGoodEntityDetails) {
        _database.insert("FreeGoodEntityDetails", freeGoodEntityDetail.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertFreeGoodExclusives(List<FreeGoodExclusives>? freeGoodExclusives) async{
    if (freeGoodExclusives != null) {
      for (FreeGoodExclusives freeGoodExclusive in freeGoodExclusives) {
        _database.insert("FreeGoodExclusives", freeGoodExclusive.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertFreeGoodGroups(List<FreeGoodGroups>? freeGoodGroups)async {
    if (freeGoodGroups != null) {
      for (FreeGoodGroups freeGoodGroup in freeGoodGroups) {
        _database.insert("FreeGoodGroups", freeGoodGroup.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertFreeGoodMasters(List<FreeGoodMasters>? freeGoodMasters)async {
    if (freeGoodMasters != null) {
      for (FreeGoodMasters freeGoodMaster in freeGoodMasters) {
        _database.insert("FreeGoodMasters", freeGoodMaster.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertFreePriceConditionOutletAttributes(List<FreePriceConditionOutletAttributes>? priceConditionOutletAttributes) async{
    if (priceConditionOutletAttributes != null) {
      for (FreePriceConditionOutletAttributes outletAttributes in priceConditionOutletAttributes) {
        _database.insert("FreePriceConditionOutletAttributes", outletAttributes.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertOutletAvailedFreeGoods(List<OutletAvailedFreeGoods>? outletAvailedFreeGoods) async{
    if (outletAvailedFreeGoods != null) {
      for (OutletAvailedFreeGoods outletAvailedFreeGood in outletAvailedFreeGoods) {
        _database.insert("OutletAvailedFreeGoods", outletAvailedFreeGood.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }
}
