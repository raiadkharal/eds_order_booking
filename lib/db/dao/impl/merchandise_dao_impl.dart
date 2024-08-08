import 'package:order_booking/db/dao/merchandise_dao.dart';
import 'package:order_booking/db/entities/merchandise/merchandise.dart';
import 'package:sqflite/sqflite.dart';

import '../../../utils/utils.dart';
import '../../entities/asset/asset.dart';

class MerchandiseDaoImpl extends MerchandiseDao{

  final Database _database;

  MerchandiseDaoImpl(this._database);

  @override
  Future<void> insertMerchandise(Merchandise merchandise) async {
    try {
      _database.insert("Merchandise", merchandise.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<Merchandise?> findMerchandiseByOutletId(int? outletId) async{
    final result = await _database.query("Merchandise",where: "outletId = ?",whereArgs: [outletId]);

    if(result.isNotEmpty){
      return Merchandise.fromJson(result.first);
    }

    return null;
  }

  @override
  Future<List<Asset>> findAllAssetsForOutlet(int outletId) async{
    final result = await _database.query("Asset",where: "outletId = ?",whereArgs: [outletId]);

      return result.map((e) => Asset.fromJson(e),).toList();
  }

  @override
  void updateAssets(List<Asset> assets) async{
    _database.transaction((txn) async{
      Batch batch = txn.batch();

      for(Asset asset in assets){
        batch.update("Asset", asset.toJson());
      }

      batch.commit(noResult: true);
    },);
  }
}