import 'package:order_booking/db/dao/price_condition_detail_dao.dart';
import 'package:order_booking/db/entities/pricing/price_condition_detail/price_condition_detail.dart';
import 'package:order_booking/db/entities/pricing/price_condition_scale/price_condition_scale.dart';
import 'package:order_booking/ui/order/pricing/price_condition_details_with_scale/price_condition_details_with_scale.dart';
import 'package:sqflite/sqflite.dart';

import '../../entities/pricing/price_condition_entities/price_condition_entities.dart';

class PriceConditionDetailDaoImpl extends PriceConditionDetailDao {
  final Database _database;

  PriceConditionDetailDaoImpl(this._database);

  @override
  Future<PriceConditionDetailsWithScale?> findPriceConditionDetails(
      int? priceConditionId, int? outletId) async {
    final result = await _database.query("PriceConditionDetail",
        where: "priceConditionId = ? and outletId = ?",
        whereArgs: [priceConditionId, outletId]);

    if (result.isNotEmpty) {
      return PriceConditionDetailsWithScale.fromJson(result.first);
    }

    return null;
  }

  @override
  Future<PriceConditionDetailsWithScale?> findPriceConditionDetailsDistribution(
      int? priceConditionId, int? distributionId) async {
    final result = await _database.query("PriceConditionDetail",
        where: "priceConditionId = ? and distributionId = ?",
        whereArgs: [priceConditionId, distributionId]);

    if (result.isNotEmpty) {
      return PriceConditionDetailsWithScale.fromJson(result.first);
    }

    return null;
  }

  @override
  Future<PriceConditionDetailsWithScale?> findPriceConditionDetailsRoute(
      int? priceConditionId, int? routeId) async {
    final result = await _database.query("PriceConditionDetail",
        where: "priceConditionId = ? and routeId = ?",
        whereArgs: [priceConditionId, routeId]);

    if (result.isNotEmpty) {
      return PriceConditionDetailsWithScale.fromJson(result.first);
    }

    return null;
  }

  @override
  Future<PriceConditionEntities?> findPriceConditionEntityOutlet(
      int? priceConditionId, int? outletId, int? bundleId) async {
    final result = await _database.rawQuery(
        "SELECT * FROM PriceConditionEntities Where priceConditionId=$priceConditionId AND outletId= $outletId AND ((bundleId NOT Null AND bundleId = $bundleId )or  bundleId is NUll OR bundleId=0)");

    if (result.isNotEmpty) {
      return PriceConditionEntities.fromJson(result.first);
    }

    return null;
  }

  @override
  Future<PriceConditionDetailsWithScale?> findPriceConditionDetailWithBundle(
      int? priceConditionId,
      int? productDefinitionId,
      int? bundleId,
      int? packageId) async {
    return await _database.transaction(
      (txn) async {
        PriceConditionDetailsWithScale parentModel = PriceConditionDetailsWithScale();

        final String priceConditionDetailQuery =
            "SELECT * FROM PriceConditionDetail Where priceConditionId= $priceConditionId AND (productDefinitionId=$productDefinitionId" +
                " OR packageId = $packageId) AND (($bundleId NOT Null AND (bundleId =$bundleId OR bundleId=0)) OR ($bundleId is Null AND bundleId is Null)) ";

        List<Map<String, dynamic>> priceConditionDetailJson =
        await txn.rawQuery(priceConditionDetailQuery);

        if(priceConditionDetailJson.isNotEmpty){
          PriceConditionDetail priceConditionDetail = PriceConditionDetail.fromJson(priceConditionDetailJson.first);

          parentModel.priceConditionDetail=priceConditionDetail;
        }

        // fetch price condition scale data

        final String priceConditionScaleQuery =
            "SELECT * FROM PriceConditionScale WHERE priceConditionDetailId = ${parentModel.priceConditionDetail?.priceConditionDetailId??0}";

        List<Map<String, dynamic>> priceConditionScaleJson =
        await txn.rawQuery(priceConditionScaleQuery);

        if(priceConditionScaleJson.isNotEmpty){
          List<PriceConditionScale> priceConditionScaleList =priceConditionScaleJson.map((e) => PriceConditionScale.fromJson(e)).toList();

          parentModel.priceConditionScaleList=priceConditionScaleList;
        }

        return parentModel;
      },
    );
  }

  @override
  Future<PriceConditionEntities?> findPriceConditionEntityRoute(
      int? priceConditionId, int? routeId, int? bundleId) async {
    final result = await _database.rawQuery(
        "SELECT * FROM PriceConditionEntities Where priceConditionId=$priceConditionId AND routeId=$routeId " +
            "AND ((bundleId NOT Null AND bundleId =$bundleId )or  bundleId is NUll OR bundleId=0)");

    if (result.isNotEmpty) {
      return PriceConditionEntities.fromJson(result.first);
    }

    return null;
  }

  @override
  Future<PriceConditionEntities?> findPriceConditionEntityDistribution(
      int? priceConditionId, int? distributionId, int? bundleId) async {
    final result = await _database.rawQuery(
        "SELECT * FROM PriceConditionEntities Where priceConditionId=$priceConditionId AND distributionId=$distributionId " +
            "AND ((bundleId NOT Null AND bundleId =$bundleId )or  bundleId is NUll OR bundleId=0)");

    if (result.isNotEmpty) {
      return PriceConditionEntities.fromJson(result.first);
    }

    return null;
  }
}
