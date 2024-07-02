import 'package:order_booking/db/dao/merchandise_dao.dart';
import 'package:order_booking/db/entities/merchandise/merchandise.dart';
import 'package:sqflite/sqflite.dart';

import '../../../utils/utils.dart';

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

}