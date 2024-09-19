import 'package:order_booking/db/entities/asset/asset.dart';
import 'package:order_booking/db/entities/merchandise/merchandise.dart';

abstract class MerchandiseDao{
  Future<void> insertMerchandise(Merchandise merchandise);

  Future<Merchandise?> findMerchandiseByOutletId(int? outletId);

  Future<List<Asset>> findAllAssetsForOutlet(int outletId);

 Future<void> updateAssets(List<Asset> assets);

  Future<void> updateMerchandise(Merchandise merchandise) ;
}