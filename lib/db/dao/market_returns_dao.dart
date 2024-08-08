import 'package:order_booking/db/entities/market_return_detail/market_return_detail.dart';
import 'package:order_booking/db/entities/market_returns/market_returns.dart';

abstract class MarketReturnsDao{

  Future<void> deleteAllMarketReturns();

  Future<void> insertMarketReturnDetails(List<MarketReturnDetail> returnList);

  Future<void> updateInvoiceIdByOutlet(int? outletId, int? invoiceId);

  Future<void> insertMarketReturn(MarketReturns? marketReturns);

  Future<int?> getMarketReturnInvoiceByOutlet(int? outletId);

  Future<List<MarketReturnDetail>?> getMarketReturnDetailsByOutletId(int? outletId);

  Future<void> deleteMarketReturnDetailByOutlet(int? outletId, int? productId);

  Future<List<MarketReturnDetail>> getAllMarketReturns(int? outletId, int? productId);

}