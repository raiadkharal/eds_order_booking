import 'package:get/get.dart';
import 'package:order_booking/db/dao/product_dao.dart';
import 'package:order_booking/db/entities/packages/package.dart';
import 'package:order_booking/db/entities/product/product.dart';
import 'package:order_booking/db/entities/product_group/product_group.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/product_stock_in_hand/product_stock_in_hand.dart';
import '../../../utils/utils.dart';
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
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (packageList != null) {
            for (Package package in packageList) {
              batch.insert("Package", package.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> insertProductGroups(List<ProductGroup>? productGroups) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (productGroups != null) {
            for (ProductGroup productGroup in productGroups) {
              batch.insert("ProductGroups", productGroup.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  Future<void> insertProducts(List<Product>? productList) async {
    try {
      await _database.transaction(
        (txn) async {
          Batch batch = txn.batch();
          if (productList != null) {
            for (Product product in productList) {
              batch.insert("Product", product.toJson(),
                  conflictAlgorithm: ConflictAlgorithm.replace);
            }
          }
          await batch.commit(noResult: true);
        },
      );
    } catch (e) {
      showToastMessage(e.toString());
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
    final result = await _database.query("Product",
        where: "productPackageId = ?", whereArgs: [packageId]);

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

  @override
  Future<List<Product>> getAllProducts() async {
    final result = await _database.rawQuery("Select * from Product");

    return result
        .map(
          (e) => Product.fromJson(e),
        )
        .toList();
  }

  @override
  Future<Product?> checkUnitProduct(int? productDefinitionId) async {
    final result = await _database.rawQuery(
        "SELECT * FROM Product WHERE unitDefinitionId= $productDefinitionId");

    if (result.isNotEmpty) {
      return Product.fromJson(result.first);
    }

    return null;
  }

  @override
  Future<Product?> findProductById(int? replacementProductId) async {
    if (replacementProductId == null) return null;

    final result = await _database
        .rawQuery("SELECT * FROM Product WHERE pk_pid=$replacementProductId");

    if (result.isNotEmpty) {
      return Product.fromJson(result.first);
    }

    return null;
  }

  @override
  Future<void> updateProductStock(
      int? productId, int unitStockInHand, int cartonStockInHand) async {
    try {
      _database.rawUpdate(
          "Update Product set unitStockInHand= ? , cartonStockInHand= ? where pk_pid= ?",
          [unitStockInHand, cartonStockInHand, productId]);
    } catch (e) {
      e.printInfo();
      // showToastMessage("Something went Wrong please try again later.");
    }
  }

  @override
  Future<ProductStockInHand?> getProductStockInHand(int? id) async {
    try {
      final result = await _database.rawQuery(
          "select pk_pid,unitStockInHand,cartonStockInHand from product where pk_pid= $id");

      if (result.isNotEmpty) {
        return ProductStockInHand.fromJson(result.first);
      }

      return ProductStockInHand(pkPid: id??0, unitStockInHand: 0, cartonStockInHand: 0);
    } catch (e) {
      e.printInfo();
      return null;
    }
  }
}
