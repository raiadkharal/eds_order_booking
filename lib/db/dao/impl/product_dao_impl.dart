import 'package:order_booking/db/dao/product_dao.dart';
import 'package:order_booking/db/entities/packages/package.dart';
import 'package:order_booking/db/entities/product/product.dart';
import 'package:order_booking/db/entities/product_group/product_group.dart';
import 'package:sqflite/sqflite.dart';

import '../../entities/order_detail/order_detail.dart';
import '../../models/product_carton_quantity/product_carton_quantity.dart';

class ProductDaoImpl extends ProductDao {
  final Database _database;

  ProductDaoImpl(this._database);

  @override
  Future<List<ProductCartonQty>> getProductCartonQuantity() async {
    final result =
        await _database.rawQuery("select pk_pid, cartonQuantity from Product");

    return result.map((json) => ProductCartonQty.fromJson(json)).toList();
  }

  @override
  Future<void> deleteAllPackages() async {
    _database.rawQuery("DELETE FROM Package");
  }

  @override
  Future<void> deleteAllProductGroups() async {
    _database.rawQuery("DELETE FROM ProductGroups");
  }

  @override
  Future<void> deleteAllProducts() async {
    _database.rawQuery("DELETE FROM Product");
  }

  @override
  Future<void> insertPackages(List<Package>? packageList) async {
    if (packageList != null) {
      for (Package package in packageList) {
        _database.insert("Package", package.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertProductGroups(List<ProductGroup>? productGroups) async {
    if (productGroups != null) {
      for (ProductGroup productGroup in productGroups) {
        _database.insert("ProductGroups", productGroup.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<void> insertProducts(List<Product>? productList) async {
    if (productList != null) {
      for (Product product in productList) {
        _database.insert("Product", product.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  @override
  Future<List<Package>> getAllPackages() async {
    final result = await _database
        .rawQuery("SELECT * FROM Package ORDER BY productPackageName ASC");

    return result
        .map(
          (json) => Package.fromJson(json),
        )
        .toList();
  }

  @override
  Future<List<ProductGroup>> getAllGroups() async {
    final result = await _database
        .rawQuery("SELECT * FROM ProductGroups ORDER BY productGroupId ASC");

    return result
        .map(
          (json) => ProductGroup.fromJson(json),
        )
        .toList();
  }

  @override
  Future<List<Product>> findAllProductsByPkg(int? packageId) async {
    final result = await _database
        .query("Product", where: "productPackageId = ?", whereArgs: [packageId]);

    return result
        .map(
          (json) => Product.fromJson(json),
        )
        .toList();
  }

  @override
  Future<List<OrderDetail>> findOrderItemsByOrderId(int? orderId) async {
    final result = await _database
        .query("OrderDetail", where: "fk_oid = ?", whereArgs: [orderId]);

    return result
        .map(
          (json) => OrderDetail.fromJson(json),
        )
        .toList();
  }
}
