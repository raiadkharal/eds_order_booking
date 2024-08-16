import 'package:order_booking/db/dao/pricing_dao.dart';
import 'package:order_booking/db/entities/outlet_availed_promotion/outlet_availed_promotion.dart';
import 'package:order_booking/db/entities/pricing/price_condition_outlet_arribute/price_condition_outlet_attribute.dart';
import 'package:order_booking/db/entities/pricing/pricing_area/pricing_area.dart';
import 'package:order_booking/model/pricing/free_price_condition_outlet_attributes/free_price_condition_outlet_attributes.dart';
import 'package:order_booking/model/pricing/outlet_availed_free_goods/outlet_availed_free_goods.dart';
import 'package:order_booking/model/pricing/price_bundle/price_bundle.dart';
import 'package:order_booking/ui/order/pricing/price_condtition_with_access_sequence/price_condtition_with_access_sequence.dart';
import 'package:sqflite/sqflite.dart';

import '../../../ui/order/pricing/free_good_output_dto/free_good_output_dto.dart';
import '../../../utils/utils.dart';
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
import '../../entities/product_quantity/product_quantity.dart';

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
  Future<void> deleteAllPriceConditionEntities() async {
    _database.rawQuery("DELETE FROM PriceConditionEntities");
  }

  @override
  Future<void> insertOutletAvailedPromotions(
      List<OutletAvailedPromotion>? outletAvailedPromotions) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (outletAvailedPromotions != null) {
            for (OutletAvailedPromotion outletPromotion
                in outletAvailedPromotions) {
              batch.insert("OutletAvailedPromotion", outletPromotion.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> insertPriceAccessSequence(
      List<PriceAccessSequence>? priceAccessSequences) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (priceAccessSequences != null) {
            for (PriceAccessSequence priceAccessSequence
                in priceAccessSequences) {
              batch.insert("PriceAccessSequence", priceAccessSequence.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> insertPriceBundles(List<PriceBundle>? priceBundles) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (priceBundles != null) {
            for (PriceBundle priceBundle in priceBundles) {
              batch.insert("PriceBundle", priceBundle.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> insertPriceCondition(
      List<PriceCondition>? priceConditions) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (priceConditions != null) {
            for (PriceCondition priceCondition in priceConditions) {
              batch.insert("PriceCondition", priceCondition.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> insertPriceConditionClasses(
      List<PriceConditionClass>? priceConditionClasses) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (priceConditionClasses != null) {
            for (PriceConditionClass priceConditionClass
                in priceConditionClasses) {
              batch.insert("PriceConditionClass", priceConditionClass.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> insertPriceConditionDetail(
      List<PriceConditionDetail>? priceConditionDetails) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (priceConditionDetails != null) {
            for (PriceConditionDetail priceConditionDetail
                in priceConditionDetails) {
              batch.insert(
                  "PriceConditionDetail", priceConditionDetail.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> insertPriceConditionEntities(
      List<PriceConditionEntities>? priceConditionEntities) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (priceConditionEntities != null) {
            for (PriceConditionEntities priceConditionEntity
                in priceConditionEntities) {
              batch.insert(
                  "PriceConditionEntities", priceConditionEntity.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> insertPriceConditionOutletAttributes(
      List<PriceConditionOutletAttribute>?
          priceConditionOutletAttributes) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (priceConditionOutletAttributes != null) {
            for (PriceConditionOutletAttribute priceConditionOutletAttribute
                in priceConditionOutletAttributes) {
              batch.insert("PriceConditionOutletAttribute",
                  priceConditionOutletAttribute.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> insertPriceConditionScales(
      List<PriceConditionScale>? priceConditionScales) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (priceConditionScales != null) {
            for (PriceConditionScale priceConditionScale
                in priceConditionScales) {
              batch.insert("PriceConditionScale", priceConditionScale.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> insertPriceConditionType(
      List<PriceConditionType>? priceConditionTypes) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (priceConditionTypes != null) {
            for (PriceConditionType priceConditionType in priceConditionTypes) {
              batch.insert("PriceConditionType", priceConditionType.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> insertFreeGoodDetails(
      List<FreeGoodDetails>? freeGoodDetails) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (freeGoodDetails != null) {
            for (FreeGoodDetails freeGoodDetail in freeGoodDetails) {
              batch.insert("FreeGoodDetails", freeGoodDetail.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> insertFreeGoodEntityDetails(
      List<FreeGoodEntityDetails>? freeGoodEntityDetails) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (freeGoodEntityDetails != null) {
            for (FreeGoodEntityDetails freeGoodEntityDetail
                in freeGoodEntityDetails) {
              batch.insert(
                  "FreeGoodEntityDetails", freeGoodEntityDetail.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> insertFreeGoodExclusives(
      List<FreeGoodExclusives>? freeGoodExclusives) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (freeGoodExclusives != null) {
            for (FreeGoodExclusives freeGoodExclusive in freeGoodExclusives) {
              batch.insert("FreeGoodExclusives", freeGoodExclusive.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> insertFreeGoodGroups(
      List<FreeGoodGroups>? freeGoodGroups) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (freeGoodGroups != null) {
            for (FreeGoodGroups freeGoodGroup in freeGoodGroups) {
              batch.insert("FreeGoodGroups", freeGoodGroup.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> insertFreeGoodMasters(
      List<FreeGoodMasters>? freeGoodMasters) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (freeGoodMasters != null) {
            for (FreeGoodMasters freeGoodMaster in freeGoodMasters) {
              batch.insert("FreeGoodMasters", freeGoodMaster.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> insertFreePriceConditionOutletAttributes(
      List<FreePriceConditionOutletAttributes>?
          priceConditionOutletAttributes) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (priceConditionOutletAttributes != null) {
            for (FreePriceConditionOutletAttributes outletAttributes
                in priceConditionOutletAttributes) {
              batch.insert("FreePriceConditionOutletAttributes",
                  outletAttributes.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> insertOutletAvailedFreeGoods(
      List<OutletAvailedFreeGoods>? outletAvailedFreeGoods) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (outletAvailedFreeGoods != null) {
            for (OutletAvailedFreeGoods outletAvailedFreeGood
                in outletAvailedFreeGoods) {
              batch.insert(
                  "OutletAvailedFreeGoods", outletAvailedFreeGood.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<int> priceConditionClassValidation() async {
    final result =
        await _database.rawQuery("Select Count(*) from PriceConditionClass");

    if (result.isNotEmpty) {
      return Sqflite.firstIntValue(result) ?? 0;
    }

    return 0;
  }

  @override
  Future<int> priceConditionValidation() async {
    final result =
        await _database.rawQuery("Select Count(*) from PriceCondition");

    if (result.isNotEmpty) {
      return Sqflite.firstIntValue(result) ?? 0;
    }

    return 0;
  }

  @override
  Future<int> priceConditionTypeValidation() async {
    final result =
        await _database.rawQuery("Select Count(*) from PriceConditionType");

    if (result.isNotEmpty) {
      return Sqflite.firstIntValue(result) ?? 0;
    }

    return 0;
  }

  @override
  Future<List<PriceConditionClass>> findPriceConditionClasses(
      int pricingLevelId) async {
    final result = await _database.rawQuery(
        "SELECT * FROM PriceConditionClass Where PriceConditionClass.pricingLevelId=$pricingLevelId Order By `order`");

    return result
        .map(
          (e) => PriceConditionClass.fromJson(e),
        )
        .toList();
  }

  @override
  Future<List<PricingArea>> findPricingArea() async {
    final result =
        await _database.rawQuery("SELECT * FROM PricingArea Order By `order`");

    return result
        .map(
          (e) => PricingArea.fromJson(e),
        )
        .toList();
  }

  @override
  Future<List<PriceConditionType>> findPriceConditionTypes(
      int? priceConditionClassId) async {
    final result = await _database.query("PriceConditionType",
        where: "priceConditionClassId = ?", whereArgs: [priceConditionClassId]);

    return result
        .map(
          (e) => PriceConditionType.fromJson(e),
        )
        .toList();
  }

  @override
  Future<List<PriceConditionWithAccessSequence>>
      getPriceConditionAndAccessSequenceByTypeId(
          int? priceConditionTypeId,
          int? vpoClassificationId,
          int? pricingGroupId,
          int? channelId,
          int? organizationId,
          int? outletPromoConfigId,
          int? customerRegistrationTypeId,
          String? date,
          int? distributionId,
          int? outletId) async {
    final result = await _database.rawQuery("SELECT PC.*,pas.* , ChannelAttribute.ChannelAttributeCount , OutletChannelAttribute.ChannelAttributeCount AS OutletChannelAttribute ,  \n" +
        "            GroupAttribute.GroupAttributeCount , OutletGroupAttribute.GroupAttributeCount AS OutletGroupAttribute, \n" +
        "            VPOClassificationAttribute.VPOClassificationAttributeCount , OutletVPOClassificationAttribute.VPOClassificationAttributeCount AS OutletVPOClassificationAttributeCount \n" +
        "            FROM PriceCondition PC \n" +
        "            INNER JOIN PriceConditionType PCT ON PCT.priceConditionTypeId=PC.priceConditionTypeId  \n" +
        "            INNER JOIN PriceConditionClass pcc ON pcc.priceConditionClassId=pct.priceConditionClassId \n" +
        "            INNER JOIN PriceAccessSequence pas ON pas.priceAccessSequenceId=pc.accessSequenceId \n" +
        "            LEFT JOIN PriceConditionEntities E ON E.priceConditionId=PC.priceConditionId\n" +
        "            LEFT JOIN ( \n" +
        "            SELECT Count(pcoa.ChannelId) AS ChannelAttributeCount,pcoa.PriceConditionId \n" +
        "            FROM PriceConditionOutletAttribute pcoa \n" +
        "            Group By pcoa.PriceConditionId \n" +
        "            ) ChannelAttribute ON ChannelAttribute.PriceConditionId = PC.PriceConditionId  \n" +
        "\n" +
        "            LEFT JOIN ( \n" +
        "            SELECT Count(pcoa.ChannelId) AS ChannelAttributeCount,pcoa.PriceConditionId \n" +
        "            FROM PriceConditionOutletAttribute pcoa \n" +
        "            Where  pcoa.ChannelId = $channelId \n" +
        "            Group By pcoa.PriceConditionId \n" +
        "            ) OutletChannelAttribute ON ChannelAttribute.PriceConditionId = PC.PriceConditionId  \n" +
        "\n" +
        "            LEFT JOIN ( \n" +
        "                     SELECT Count(pcoa.OutletGroupId) AS GroupAttributeCount, pcoa.PriceConditionId \n" +
        "                     FROM PriceConditionOutletAttribute pcoa \n" +
        "                     Group By pcoa.PriceConditionId \n" +
        "                     ) GroupAttribute ON GroupAttribute.PriceConditionId = PC.PriceConditionId \n" +
        "            LEFT JOIN ( \n" +
        "                     SELECT Count(pcoa.OutletGroupId) AS GroupAttributeCount, pcoa.PriceConditionId \n" +
        "                     FROM PriceConditionOutletAttribute pcoa \n" +
        "                     Where pcoa.OutletGroupId = $pricingGroupId \n" +
        "                     Group By pcoa.PriceConditionId \n" +
        "                     ) OutletGroupAttribute ON OutletGroupAttribute.PriceConditionId = PC.PriceConditionId \n" +
        "\n" +
        "            LEFT JOIN ( \n" +
        "                                            SELECT Count(pcoa.VPOClassificationId) AS VPOClassificationAttributeCount, pcoa.PriceConditionId \n" +
        "                                            FROM PriceConditionOutletAttribute pcoa \n" +
        "                                            Group By pcoa.PriceConditionId \n" +
        "                                            )VPOClassificationAttribute ON VPOClassificationAttribute.PriceConditionId = PC.PriceConditionId \n" +
        "                     \n" +
        "\n" +
        "            LEFT JOIN ( \n" +
        "                                            SELECT Count(pcoa.VPOClassificationId) AS VPOClassificationAttributeCount, pcoa.PriceConditionId \n" +
        "                                            FROM PriceConditionOutletAttribute pcoa \n" +
        "                                            Where pcoa.VPOClassificationId = $vpoClassificationId \n" +
        "                                            Group By pcoa.PriceConditionId \n" +
        "                                             ) OutletVPOClassificationAttribute ON OutletVPOClassificationAttribute.PriceConditionId = PC.PriceConditionId \n" +
        "                     \n" +
        "                     \n" +
        "            Where PC.priceConditionTypeId = $priceConditionTypeId  AND \n" +
        "              (PC.IsBundle = 0 OR PC.IsBundle IS NULL) \n" +
        "            AND ($organizationId = 0 OR $organizationId IS NULL OR PC.OrganizationId = $organizationId) \n" +
        "            AND ( \n" +
        "            (PCC.Code IS NULL OR PCC.Code  <> 'Tax') OR \n" +
        "            (pc.CustomerRegistrationTypeId = 3) OR \n" +
        "            (PCC.Code = 'Tax' AND pc.CustomerRegistrationTypeId = $customerRegistrationTypeId) \n" +
        "            ) \n" +
        "            AND (ChannelAttribute.ChannelAttributeCount > 0  OR ( \n" +
        "            SELECT Count(pcoa1.ChannelId) \n" +
        "            FROM PriceConditionOutletAttribute pcoa1 \n" +
        "            WHERE pcoa1.PriceConditionId = PC.PriceConditionId \n" +
        "            ) = 0 \n" +
        "             ) \n" +
        "            AND (GroupAttribute.GroupAttributeCount > 0  OR \n" +
        "            ( \n" +
        "             SELECT Count(pcoa1.OutletGroupId) \n" +
        "             FROM PriceConditionOutletAttribute pcoa1 \n" +
        "             WHERE pcoa1.PriceConditionId = PC.PriceConditionId  \n" +
        "             ) = 0 \n" +
        "             ) \n" +
        "            AND  (VPOClassificationAttribute.VPOClassificationAttributeCount > 0  OR \n" +
        "            ( \n" +
        "             SELECT Count(pcoa1.VPOClassificationId) \n" +
        "             FROM PriceConditionOutletAttribute pcoa1 \n" +
        "             WHERE pcoa1.PriceConditionId = PC.PriceConditionId  \n" +
        "             ) = 0 \n" +
        "             ) \n" +
        "            AND ( \n" +
        "                    ($outletPromoConfigId IS NULL OR $outletPromoConfigId=2)  \n" +
        "            OR ($outletPromoConfigId=1 AND pct.IsPromo = 0)  \n" +
        "            ) \n" +
        "            AND Cast(PC.ValidFrom AS Date)<=Cast('$date' as Date) AND Cast(PC.ValidTo AS Date) >= Cast('$date' as Date)   \n" +
        "             AND (PAS.SequenceCode <> 'DISTRIBUTION_PRODUCT' OR (PAS.SequenceCode = 'DISTRIBUTION_PRODUCT' AND E.DistributionId = $distributionId))\n" +
        "             \t\t\tAND (PAS.SequenceCode <> 'OUTLET_PRODUCT' OR (PAS.SequenceCode = 'OUTLET_PRODUCT' AND E.OutletId = $outletId))\n" +
        "             order by pas.`order`");

    return result
        .map(
          (e) => PriceConditionWithAccessSequence.fromJson(e),
        )
        .toList();
  }

/*  Future<List<Map<String, dynamic>>> getPriceConditionAndAccessSequenceByTypeId(
      int priceConditionTypeId,
      int VPOClassificationId,
      int PricingGroupId,
      int ChannelId,
      int OrganizationId,
      int OutletPromoConfigId,
      int CustomerRegistrationTypeId,
      String date,
      int? DistributionId,
      int? OutletId) async {

    final List<Map<String, dynamic>> result = await _database.rawQuery('''
      SELECT PC.*, pas.*, ChannelAttribute.ChannelAttributeCount, OutletChannelAttribute.ChannelAttribute,
             GroupAttribute.GroupAttributeCount, OutletGroupAttribute.GroupAttribute,
             VPOClassificationAttribute.VPOClassificationAttributeCount, OutletVPOClassificationAttribute.OutletVPOClassificationAttributeCount
      FROM PriceCondition PC
      INNER JOIN PriceConditionType PCT ON PCT.priceConditionTypeId = PC.priceConditionTypeId
      INNER JOIN PriceConditionClass PCC ON PCC.priceConditionClassId = PCT.priceConditionClassId
      INNER JOIN PriceAccessSequence PAS ON PAS.priceAccessSequenceId = PC.accessSequenceId
      LEFT JOIN PriceConditionEntities E ON E.priceConditionId = PC.priceConditionId
      LEFT JOIN (
        SELECT COUNT(pcoa.ChannelId) AS ChannelAttributeCount, pcoa.PriceConditionId
        FROM PriceConditionOutletAttribute pcoa
        GROUP BY pcoa.PriceConditionId
      ) ChannelAttribute ON ChannelAttribute.PriceConditionId = PC.PriceConditionId
      LEFT JOIN (
        SELECT COUNT(pcoa.ChannelId) AS ChannelAttributeCount, pcoa.PriceConditionId
        FROM PriceConditionOutletAttribute pcoa
        WHERE pcoa.ChannelId = ?
        GROUP BY pcoa.PriceConditionId
      ) OutletChannelAttribute ON OutletChannelAttribute.PriceConditionId = PC.PriceConditionId
      LEFT JOIN (
        SELECT COUNT(pcoa.OutletGroupId) AS GroupAttributeCount, pcoa.PriceConditionId
        FROM PriceConditionOutletAttribute pcoa
        GROUP BY pcoa.PriceConditionId
      ) GroupAttribute ON GroupAttribute.PriceConditionId = PC.PriceConditionId
      LEFT JOIN (
        SELECT COUNT(pcoa.OutletGroupId) AS GroupAttributeCount, pcoa.PriceConditionId
        FROM PriceConditionOutletAttribute pcoa
        WHERE pcoa.OutletGroupId = ?
        GROUP BY pcoa.PriceConditionId
      ) OutletGroupAttribute ON OutletGroupAttribute.PriceConditionId = PC.PriceConditionId
      LEFT JOIN (
        SELECT COUNT(pcoa.VPOClassificationId) AS VPOClassificationAttributeCount, pcoa.PriceConditionId
        FROM PriceConditionOutletAttribute pcoa
        GROUP BY pcoa.PriceConditionId
      ) VPOClassificationAttribute ON VPOClassificationAttribute.PriceConditionId = PC.PriceConditionId
      LEFT JOIN (
        SELECT COUNT(pcoa.VPOClassificationId) AS VPOClassificationAttributeCount, pcoa.PriceConditionId
        FROM PriceConditionOutletAttribute pcoa
        WHERE pcoa.VPOClassificationId = ?
        GROUP BY pcoa.PriceConditionId
      ) OutletVPOClassificationAttribute ON OutletVPOClassificationAttribute.PriceConditionId = PC.PriceConditionId
      WHERE PC.priceConditionTypeId = ?
        AND (PC.IsBundle = 0 OR PC.IsBundle IS NULL)
        AND (? = 0 OR ? IS NULL OR PC.OrganizationId = ?)
        AND (
          (PCC.Code IS NULL OR PCC.Code <> 'Tax')
          OR (PC.CustomerRegistrationTypeId = 3)
          OR (PCC.Code = 'Tax' AND PC.CustomerRegistrationTypeId = ?)
        )
        AND (ChannelAttribute.ChannelAttributeCount > 0 OR (
          SELECT COUNT(pcoa1.ChannelId)
          FROM PriceConditionOutletAttribute pcoa1
          WHERE pcoa1.PriceConditionId = PC.PriceConditionId
        ) = 0)
        AND (GroupAttribute.GroupAttributeCount > 0 OR (
          SELECT COUNT(pcoa1.OutletGroupId)
          FROM PriceConditionOutletAttribute pcoa1
          WHERE pcoa1.PriceConditionId = PC.PriceConditionId
        ) = 0)
        AND (VPOClassificationAttribute.VPOClassificationAttributeCount > 0 OR (
          SELECT COUNT(pcoa1.VPOClassificationId)
          FROM PriceConditionOutletAttribute pcoa1
          WHERE pcoa1.PriceConditionId = PC.PriceConditionId
        ) = 0)
        AND (
          (? IS NULL OR ? = 2)
          OR (? = 1 AND PCT.IsPromo = 0)
        )
        AND CAST(PC.ValidFrom AS Date) <= CAST(? AS Date)
        AND CAST(PC.ValidTo AS Date) >= CAST(? AS Date)
        AND (PAS.SequenceCode <> 'DISTRIBUTION_PRODUCT' OR (PAS.SequenceCode = 'DISTRIBUTION_PRODUCT' AND E.DistributionId = ?))
        AND (PAS.SequenceCode <> 'OUTLET_PRODUCT' OR (PAS.SequenceCode = 'OUTLET_PRODUCT' AND E.OutletId = ?))
      ORDER BY PAS.order
    ''', [
      ChannelId,
      PricingGroupId,
      VPOClassificationId,
      priceConditionTypeId,
      OrganizationId,
      OrganizationId,
      OrganizationId,
      CustomerRegistrationTypeId,
      OutletPromoConfigId,
      OutletPromoConfigId,
      OutletPromoConfigId,
      date,
      date,
      DistributionId,
      OutletId
    ]);

    return result;
  }*/

  @override
  Future<void> insertTempOrderQty(
      List<ProductQuantity> productQuantities) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          for (ProductQuantity productQuantity in productQuantities) {
            batch.insert("ProductQuantity", productQuantity.toJson(),
                conflictAlgorithm: ConflictAlgorithm.replace);
          }

          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<List<int>> getBundleIdsForConditionType(
      int? productDefId, int? conditionTypeId) async {
    final List<Map<String, dynamic>> result = await _database.rawQuery('''
      SELECT DISTINCT b.bundleId FROM PriceCondition pc
      INNER JOIN PriceBundle b ON pc.priceConditionId = b.priceConditionId
      INNER JOIN PriceConditionDetail pcd ON b.bundleId = pcd.bundleId
      AND pcd.productDefinitionId = ?
      WHERE pc.priceConditionTypeId = ?
      AND pc.isBundle = 1
    ''', [productDefId, conditionTypeId]);

    return result.map((row) => row['bundleId'] as int).toList();
  }

  @override
  Future<int> getBundleMinQty(int? bundleId) async {
    final result = await _database.rawQuery(
        "SELECT  bundleMinimumQuantity  FROM PriceBundle WHERE BundleId = ?",
        [bundleId]);

    return result.first["bundleMinimumQuantity"] as int;
  }

  @override
  Future<int> getBundleProductCount(int? bundleId) async {
    final result = await _database.rawQuery(
        "SELECT COUNT(priceConditionDetailId) FROM PriceConditionDetail WHERE bundleId = ?",
        [bundleId]);

    if (result.isNotEmpty) {
      return Sqflite.firstIntValue(result) ?? 0;
    }

    return 0;
  }

  @override
  Future<int> getCalculatedBundleProdCount(int? bundleId) async {
    final result = await _database.rawQuery(
        "SELECT COUNT(pcd.PriceConditionDetailId)" +
            "  FROM PriceConditionDetail pcd" +
            "    INNER JOIN ProductQuantity pl " +
            "    ON pl.ProductDefinitionId = pcd.productDefinitionId" +
            "    AND pl.Quantity >= ifNull(pcd.minimumQuantity,1)" +
            "  WHERE pcd.bundleId = ?",
        [bundleId]);

    if (result.isNotEmpty) {
      return Sqflite.firstIntValue(result) ?? 0;
    }

    return 0;
  }

  @override
  Future<int> getBundleProdTotalQty(int? bundleId) async {
    final result = await _database.rawQuery(
        "SELECT SUM(pl.Quantity)" +
            "  FROM PriceConditionDetail pcd" +
            "    INNER JOIN ProductQuantity pl " +
            "    ON pl.ProductDefinitionId = pcd.productDefinitionId" +
            "    AND pl.Quantity >= ifNull(pcd.minimumQuantity,1)" +
            "  WHERE pcd.bundleId = ?",
        [bundleId]);

    if (result.isNotEmpty) {
      return Sqflite.firstIntValue(result) ?? 0;
    }

    return 0;
  }

  @override
  Future<List<PriceConditionWithAccessSequence>>
      getPriceConditionAndAccessSequenceByTypeIdWithBundle(
          int? priceConditionTypeId, List<int> bundlesToApply) async {
    final result = await _database.rawQuery(
        "SELECT * from PriceCondition pc " +
            "INNER JOIN PriceAccessSequence pas ON pc.accessSequenceId=pas.priceAccessSequenceId\n" +
            "INNER JOIN PriceBundle b ON b.PriceConditionId = pc.PriceConditionId  \n" +
            "Where pc.priceConditionTypeId= ? AND b.bundleId IN (?) order by pas.`order` ",
        [priceConditionTypeId, bundlesToApply]);

    return result
        .map(
          (e) => PriceConditionWithAccessSequence.fromJson(e),
        )
        .toList();
  }

  @override
  Future<OutletAvailedPromotion?> getAlreadyAvailedPromo(
      int? outletId,
      int? priceConditionId,
      int? priceConditionDetailId,
      int? productDefinitionId,
      int? productId) async {
    final result = await _database.rawQuery(" Select\t$outletId AS outletId,\n" +
        "    $priceConditionId AS priceConditionId,\n" +
        "    $priceConditionDetailId AS priceConditionDetailId,\n" +
        "    $productDefinitionId AS productDefinitionId,\n" +
        "    $productId AS productId,\n" +
        "    OAP.packageId AS packageId,\n" +
        "    Sum (OAP.Amount) AS amount ,\n" +
        "    Sum(OAP.Quantity) AS quantity\n" +
        "\n" +
        "\n" +
        "    From\tOutletAvailedPromotion OAP\n" +
        "    INNER JOIN PriceCondition PC ON PC.PriceConditionId = OAP.PriceConditionId\n" +
        "    INNER JOIN PriceConditionType PCT ON PCT.PriceConditionTypeId = PC.priceConditionTypeId\n" +
        "    LEFT JOIN Product P ON P.productId = OAP.productId\n" +
        "    Where\tOAP.OutletId =  $outletId AND\n" +
        "    OAP.PriceConditionId = $priceConditionId AND\n" +
        "            (\n" +
        "\t\t\t\t(PCT.PCDefinitionLevelId = 2 AND (OAP.packageId = P.pkgId OR PC.CombinedLimitBy IS NOT NULL)) OR\n" +
        "            (OAP.PriceConditionDetailId = $priceConditionDetailId)\n" +
        "\t\t\t)");

    if (result.isNotEmpty) {
      return OutletAvailedPromotion.fromJson(result.first);
    }

    return null;
  }

  @override
  Future<List<PriceAccessSequence>> getAccessSequenceByTypeId() async {
    final result = await _database.rawQuery(
        "SELECT * from PriceAccessSequence pc where pricingTypeId = 1 order by `order`");

    return result
        .map(
          (e) => PriceAccessSequence.fromJson(e),
        )
        .toList();
  }

  @override
  Future<List<FreeGoodGroups>> appliedFreeGoodGroups(
      int? outletId,
      int? channelId,
      int? vpoClassificationId,
      int? pricingGroupId,
      int? routeId,
      int? distributionId,
      int? productDefinitionId,
      int? accessSequenceId,
      int? outletIdToCheckAttribute) async {
    final result = await _database.rawQuery("SELECT    DISTINCT fgg.id , fgg.minimumQuantity, fgg.typeId, --fgm.IsBundle,\n" +
        "                        fgg.freeQuantityTypeId, fgg.forEachQuantity , fgg.freeGoodMasterId,\n" +
        "                        outletChannelAttributeCount.ChannelAttributeCount AS outletChannelAttributeCount ,\n" +
        "                        Count (channnelAttributeCount.channelId) AS channelAttributeCount,\n" +
        "                        outletGroupAttributeCount.GroupAttributeCount as outletGroupAttributeCount ,\n" +
        "                         Count (groupAttributeCount.outletGroupId) AS groupAttributeCount,\n" +
        "                         outletVPOAttributeCount.VPOAttributeCount AS outletVPOAttributeCount,\n" +
        "                         Count (VPOAttributeCount.vpoClassificationId) AS vpoAttributeCount\n" +
        "        FROM      FreeGoodGroups fgg\n" +
        "                 INNER JOIN  FreeGoodMasters fgm ON    fgg.freeGoodMasterId = fgm.freeGoodMasterId AND fgm.isActive = 1 AND fgm.accessSequenceId=$accessSequenceId\n" +
        "                 INNER JOIN  FreeGoodDetails fgd ON    fgd.freeGoodGroupId = fgg.id AND fgd.isActive = 1\n" +
        "                 LEFT JOIN   FreeGoodEntityDetails fged ON fged.freeGoodMasterId = fgm.freeGoodMasterId\n" +
        "                 INNER JOIN  Outlet O ON O.mOutletId =$outletIdToCheckAttribute\n" +
        "                 --LEFT JOIN FreePriceConditionOutletAttributes  outletChannelAttributeCount ON outletChannelAttributeCount.channelId=O.channelId\n" +
        "                 LEFT JOIN (SELECT Count(fpcoa.channelId) AS ChannelAttributeCount, fpcoa.freeGoodId  FROM FreePriceConditionOutletAttributes  fpcoa Where fpcoa.channelId=$channelId Group By fpcoa.freeGoodId)  outletChannelAttributeCount ON outletChannelAttributeCount.freeGoodId=fgm.freeGoodMasterId                  \n" +
        "                 LEFT JOIN FreePriceConditionOutletAttributes  channnelAttributeCount ON channnelAttributeCount.channelId IS NOT NULL\n" +
        "                 LEFT JOIN (SELECT Count(fpcoa.outletGroupId) AS GroupAttributeCount, fpcoa.freeGoodId  FROM FreePriceConditionOutletAttributes  fpcoa Where fpcoa.outletGroupId=$pricingGroupId Group By fpcoa.freeGoodId)  outletGroupAttributeCount ON outletGroupAttributeCount.freeGoodId=fgm.freeGoodMasterId\n" +
        "                 LEFT JOIN FreePriceConditionOutletAttributes  groupAttributeCount ON groupAttributeCount.outletGroupId IS NOT NULL\n" +
        "                 --LEFT JOIN FreePriceConditionOutletAttributes  outletVPOAttributeCount ON outletVPOAttributeCount.vpoClassificationId=O.vpoClassificationId\n" +
        "                 \n" +
        "                 LEFT JOIN (SELECT Count(fpcoa.vpoClassificationId) AS VPOAttributeCount, fpcoa.freeGoodId  FROM FreePriceConditionOutletAttributes  fpcoa Where fpcoa.vpoClassificationId=$vpoClassificationId Group By fpcoa.freeGoodId)  outletVPOAttributeCount ON outletVPOAttributeCount.freeGoodId=fgm.freeGoodMasterId\n" +
        "               \n" +
        "                 LEFT JOIN FreePriceConditionOutletAttributes  VPOAttributeCount ON VPOAttributeCount.outletGroupId IS NOT NULL\n" +
        "        WHERE     fgd.ProductDefinitionId=$productDefinitionId\n" +
        "                 AND (\n" +
        "                       --(@AccessSequenceId = @GlobalAccessSequenc AND fged.FreeGoodEntityDetailId IS NULL)\n" +
        "                       ($accessSequenceId = 21 AND fged.freeGoodEntityDetailId IS NULL)\n" +
        "                    OR  (\n" +
        "                       fged.freeGoodEntityDetailId IS NOT NULL And    (fged.outletId = $outletId OR fged.routeId = $routeId OR fged.channelId = O.channelId OR fged.distributionId = $distributionId)\n" +
        "                       )\n" +
        "                    )\n" +
        "                 AND    fgg.isActive = 1 AND fgg.isDeleted=0\n" +
        "                 AND O.outletPromoConfigId<>1");

    return result
        .map(
          (e) => FreeGoodGroups.fromJson(e),
        )
        .toList();
  }

  @override
  Future<int> getFreeGoodDetailCount(int? freeGoodGroupId) async {
    final result = await _database.rawQuery(
        "Select COUNT(fgd.freeGoodDetailId) from FreeGoodDetails fgd where fgd.freeGoodGroupId = $freeGoodGroupId");

    if (result.isNotEmpty) {
      return Sqflite.firstIntValue(result) ?? 0;
    }

    return 0;
  }

  @override
  Future<List<FreeGoodDetails>> getFreeGoodDetail(int? freeGoodGroupId) async {
    final result = await _database.rawQuery(
        "Select * from FreeGoodDetails fgd where fgd.freeGoodGroupId = $freeGoodGroupId");

    return result
        .map(
          (e) => FreeGoodDetails.fromJson(e),
        )
        .toList();
  }

  @override
  Future<int> getFreeGoodGroupMaxQuantity(int? freeGoodGroupId) async {
    final result = await _database.rawQuery(
        "Select fgg.maximumQuantity from FreeGoodGroups fgg where fgg.id = $freeGoodGroupId");

    if (result.isNotEmpty) {
      return Sqflite.firstIntValue(result) ?? 0;
    }

    return 0;
  }

  @override
  Future<List<FreeGoodOutputDTO>> getFreeGoodGroupDetails(
      int? freeGoodGroupId) async {
    final result = await _database.rawQuery(
        "Select * from FreeGoodDetails where freeGoodGroupId = $freeGoodGroupId");

    return result
        .map(
          (e) => FreeGoodOutputDTO.fromJson(e),
        )
        .toList();
  }

  @override
  Future<List<FreeGoodOutputDTO>> getFreeGoodExclusiveDetails(
      int? freeGoodGroupId) async {
    final result = await _database.rawQuery(
        "Select *, quantity AS freeGoodQuantity from FreeGoodExclusives where freeGoodGroupId = $freeGoodGroupId");

    return result
        .map(
          (e) => FreeGoodOutputDTO.fromJson(e),
        )
        .toList();
  }

  @override
  Future<List<int>> getPromoBaseProduct(int? freeGoodGroupId) async {
    final result = await _database.rawQuery(
        "Select productDefinitionId from FreeGoodDetails where freeGoodGroupId = $freeGoodGroupId");

    List<int> ids = [];
    for (var map in result) {
      ids.add(map['productDefinitionId'] as int);
    }
    return ids;
  }

  @override
  Future<int> getAlreadyAvailedFreeGoods(int? freeGoodGroupId,
      int? freeGoodDetailId, int? freeGoodExclusiveId, int? outletId) async {
    final result = await _database.rawQuery(
        "Select SUM(quantity) from OutletAvailedFreeGoods where freeGoodGroupId = $freeGoodGroupId AND freeGoodDetailId = $freeGoodDetailId AND outletId = $outletId AND freeGoodExclusiveId = $freeGoodExclusiveId");

    if (result.isNotEmpty) {
      return Sqflite.firstIntValue(result) ?? 0;
    }

    return 0;
  }
}
