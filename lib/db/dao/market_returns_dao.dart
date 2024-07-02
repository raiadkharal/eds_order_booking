import 'package:order_booking/db/entities/market_return_detail/market_return_detail.dart';

abstract class MarketReturnsDao{

  Future<void> deleteAllMarketReturns();

  Future<void> insertMarketReturnDetails(List<MarketReturnDetail> returnList);

}