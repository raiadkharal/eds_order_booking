import 'package:order_booking/ui/order/pricing/price_condition_details_with_scale/price_condition_details_with_scale.dart';

import '../entities/pricing/price_condition_entities/price_condition_entities.dart';

abstract class PriceConditionDetailDao{

  Future<PriceConditionDetailsWithScale?> findPriceConditionDetails(int? priceConditionId, int? outletId);

  Future<PriceConditionDetailsWithScale?> findPriceConditionDetailsDistribution(int? priceConditionId, int? distributionId);

  Future<PriceConditionDetailsWithScale?> findPriceConditionDetailsRoute(int? priceConditionId, int? routeId);

  Future<PriceConditionEntities?> findPriceConditionEntityOutlet(int? priceConditionId, int? outletId, int? bundleId);

  Future<PriceConditionDetailsWithScale?> findPriceConditionDetailWithBundle(int? priceConditionId, int? productDefinitionId, int? bundleId, int? packageId);

  Future<PriceConditionEntities?> findPriceConditionEntityRoute(int? priceConditionId, int? routeId, int? bundleId);

  Future<PriceConditionEntities?> findPriceConditionEntityDistribution(int? priceConditionId, int? distributionId, int? bundleId);

}