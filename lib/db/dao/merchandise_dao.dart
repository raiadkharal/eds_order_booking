import 'package:order_booking/db/entities/merchandise/merchandise.dart';

abstract class MerchandiseDao{
  Future<void> insertMerchandise(Merchandise merchandise);
}