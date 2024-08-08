import 'package:order_booking/db/entities/order_detail/order_detail.dart';
import 'package:order_booking/db/entities/packages/package.dart';
import 'package:order_booking/db/entities/product/product.dart';
import 'package:order_booking/db/entities/product_group/product_group.dart';
import 'package:order_booking/model/product_stock_in_hand/product_stock_in_hand.dart';

import '../models/product_carton_quantity/product_carton_quantity.dart';

abstract class ProductDao {
  Future<List<ProductCartonQty>> getProductCartonQuantity();

  Future<void> deleteAllPackages();

  Future<void> deleteAllProductGroups();

  Future<void> deleteAllProducts();

  Future<void> insertProductGroups(List<ProductGroup>? productGroups);

  Future<void> insertPackages(List<Package>? packageList);

  Future<void> insertProducts(List<Product>? productList);

  Future<List<Package>> getAllPackages();
  Future<List<ProductGroup>> getAllGroups();

  Future<List<Product>> findAllProductsByPkg(int? packageId);

  Future<List<OrderDetail>> findOrderItemsByOrderId(int? orderId);

  Future<List<Product>> getAllProducts();

  Future<Product?> checkUnitProduct(int? productDefinitionId);

  Future<Product?> findProductById(int? replacementProductId);

  Future<void> updateProductStock(int? productId, int unitStockInHand, int cartonStockInHand);

  Future<ProductStockInHand?> getProductStockInHand(int? id);
}