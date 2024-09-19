import 'package:order_booking/db/dao/market_returns_dao.dart';
import 'package:order_booking/db/entities/market_return_detail/market_return_detail.dart';
import 'package:order_booking/db/entities/market_returns/market_returns.dart';
import 'package:order_booking/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class MarketReturnsDaoImpl extends MarketReturnsDao {
  final Database _database;

  MarketReturnsDaoImpl(this._database);

  @override
  Future<void> deleteAllMarketReturns() async {
    _database.rawQuery("Delete From MarketReturnDetails");
  }

  @override
  Future<void> insertMarketReturnDetails(
      List<MarketReturnDetail> returnList) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          for (MarketReturnDetail returnDetail in returnList) {
            batch.insert("MarketReturnDetails", returnDetail.toJson(),
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
  Future<void> updateInvoiceIdByOutlet(int? outletId, int? invoiceId) async {
    try {
      _database.rawUpdate(
          "UPDATE MarketReturnDetails SET invoiceId= ? where outletId= ?",
          [invoiceId, outletId]);
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> insertMarketReturn(MarketReturns? marketReturns) async {
    if (marketReturns == null) return;

    _database.insert("MarketReturns", marketReturns.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<MarketReturnDetail>?> getMarketReturnDetailsByOutletId(
      int? outletId) async {
    final result = await _database.query("MarketReturnDetails",
        where: "outletId = ?", whereArgs: [outletId]);

    return result
        .map(
          (e) => MarketReturnDetail.fromJson(e),
        )
        .toList();
  }

  @override
  Future<int?> getMarketReturnInvoiceByOutlet(int? outletId) async {
    final result = await _database
        .query("MarketReturns", where: "outletId = ?", whereArgs: [outletId]);

    if (result.isNotEmpty) {
      return result.first['invoiceId'] as int;
    }

    return null;
  }

  @override
  Future<void> deleteMarketReturnDetailByOutlet(
      int? outletId, int? productId) async {
    _database.rawDelete(
        "Delete from MarketReturnDetails where outletId=$outletId and productId=$productId");
  }

  @override
  Future<List<MarketReturnDetail>> getAllMarketReturns(
      int? outletId, int? productId) async{
    final result = await _database.query("MarketReturnDetails",
        where: "outletId = ? and productId = ?", whereArgs: [outletId,productId]);

    return result
        .map(
          (e) => MarketReturnDetail.fromJson(e),
    )
        .toList();
  }
}
