import 'package:order_booking/db/dao/market_returns_dao.dart';
import 'package:order_booking/db/entities/market_return_detail/market_return_detail.dart';
import 'package:sqflite/sqflite.dart';

class MarketReturnsDaoImpl extends MarketReturnsDao {
  final Database _database;

  MarketReturnsDaoImpl(this._database);

  @override
  Future<void> deleteAllMarketReturns() async {
    _database.rawQuery("Delete From MarketReturnDetails");
  }

  @override
  Future<void> insertMarketReturnDetails(List<MarketReturnDetail> returnList) async{
    for (MarketReturnDetail returnDetail in returnList) {
      _database.insert("MarketReturnDetails", returnDetail.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }
}
