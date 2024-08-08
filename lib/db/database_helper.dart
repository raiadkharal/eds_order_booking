import 'package:order_booking/utils/sql_queries.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _databaseVersion = 2;
  static const String _databaseName = "eds";

  DatabaseHelper._privateConstructor();

  static Future<Database> getDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (database, version) async {
        await createTables(database);
      },
      onUpgrade: (database, oldVersion, newVersion) async {
        await upgradeTables(database);
      },
      onDowngrade: (database, oldVersion, newVersion) async {
        await upgradeTables(database);
      },
    );
  }

  static Future<void> createTables(Database database) async {
    database.execute(SqlQueries.createAssetTable);
    database.execute(SqlQueries.createAvailableStockTable);
    database.execute(SqlQueries.createCartonPriceBreakDownTable);
    database.execute(SqlQueries.createCustomerInputTable);
    database.execute(SqlQueries.createMarketReturnReasonTable);
    database.execute(SqlQueries.createLookUpTable);
    database.execute(SqlQueries.createMarketReturnDetailsTable);
    database.execute(SqlQueries.createMarketReturnsTable);
    database.execute(SqlQueries.createMerchandiseTable);
    database.execute(SqlQueries.createOrderTable);
    database.execute(SqlQueries.createOrderDetailTable);
    database.execute(SqlQueries.createUnitPriceBreakdownTable);
    database.execute(SqlQueries.createOrderStatusTable);
    database.execute(SqlQueries.createOutletTable);
    database.execute(SqlQueries.createOutletAvailedPromotionTable);
    database.execute(SqlQueries.createPackageTable);
    database.execute(SqlQueries.createProductTable);
    database.execute(SqlQueries.createProductGroupTable);
    database.execute(SqlQueries.createPromotionTable);
    database.execute(SqlQueries.createRouteTable);
    database.execute(SqlQueries.createTaskTable);

    //pricing tables
    database.execute(SqlQueries.createFreeGoodDetailsTable);
    database.execute(SqlQueries.createFreeGoodsExclusivesTable);
    database.execute(SqlQueries.createFreeGoodEntityDetailsTable);
    database.execute(SqlQueries.createFreeGoodMasterTable);
    database.execute(SqlQueries.createFreeGoodGroupsTable);
    database.execute(SqlQueries.createFreePriceConditionOutletAttributesTable);
    database.execute(SqlQueries.createOutletAvailedFreeGoodsTable);
    database.execute(SqlQueries.createPriceAccessSequenceTable);
    database.execute(SqlQueries.createPriceBundleTable);
    database.execute(SqlQueries.createPriceConditionTable);
    database.execute(SqlQueries.createPriceConditionEntitiesTable);
    database.execute(SqlQueries.createPriceConditionDetailTable);
    database.execute(SqlQueries.createPriceConditionAvailedTable);
    database.execute(SqlQueries.createPriceConditionClassTable);
    database.execute(SqlQueries.createPriceConditionOutletAttributesTable);
    database.execute(SqlQueries.createPriceConditionScaleTable);
    database.execute(SqlQueries.createPriceConditionTypeTable);
    database.execute(SqlQueries.createPriceScaleBasisTable);
    database.execute(SqlQueries.createPricingAreaTable);
    database.execute(SqlQueries.createPricingGroupsTable);
    database.execute(SqlQueries.createPricingLevelsTable);
    database.execute(SqlQueries.createProductQuantityTable);
    database.execute(SqlQueries.createOrderAndAvailableQuantityTable);

  }

  static Future<void> upgradeTables(Database database) async {

    database.execute(SqlQueries.dropAssetTable);
    database.execute(SqlQueries.dropAvailableStockTable);
    database.execute(SqlQueries.dropCartonPriceBreakDownTable);
    database.execute(SqlQueries.dropCustomerInputTable);
    database.execute(SqlQueries.dropMarketReturnReasonTable);
    database.execute(SqlQueries.dropLookUpTable);
    database.execute(SqlQueries.dropMarketReturnDetailsTable);
    database.execute(SqlQueries.dropMarketReturnsTable);
    database.execute(SqlQueries.dropMerchandiseTable);
    database.execute(SqlQueries.dropOrderTable);
    database.execute(SqlQueries.dropOrderDetailTable);
    database.execute(SqlQueries.dropUnitPriceBreakdownTable);
    database.execute(SqlQueries.dropOrderStatusTable);
    database.execute(SqlQueries.dropOutletTable);
    database.execute(SqlQueries.dropOutletAvailedPromotionTable);
    database.execute(SqlQueries.dropPackageTable);
    database.execute(SqlQueries.dropProductTable);
    database.execute(SqlQueries.dropProductGroupTable);
    database.execute(SqlQueries.dropPromotionTable);
    database.execute(SqlQueries.dropRouteTable);
    database.execute(SqlQueries.dropTaskTable);

    // Pricing tables
    database.execute(SqlQueries.dropFreeGoodsDetailTable);
    database.execute(SqlQueries.dropFreeGoodsExclusivesTable);
    database.execute(SqlQueries.dropFreeGoodEntityDetailsTable);
    database.execute(SqlQueries.dropFreeGoodMasterTable);
    database.execute(SqlQueries.dropFreeGoodGroupsTable);
    database.execute(SqlQueries.dropFreePriceConditionOutletAttributesTable);
    database.execute(SqlQueries.dropOutletAvailedFreeGoodsTable);
    database.execute(SqlQueries.dropPriceAccessSequenceTable);
    database.execute(SqlQueries.dropPriceBundleTable);
    database.execute(SqlQueries.dropPriceConditionTable);
    database.execute(SqlQueries.dropPriceConditionEntitiesTable);
    database.execute(SqlQueries.dropPriceConditionDetailTable);
    database.execute(SqlQueries.dropPriceConditionAvailedTable);
    database.execute(SqlQueries.dropPriceConditionClassTable);
    database.execute(SqlQueries.dropPriceConditionOutletAttributesTable);
    database.execute(SqlQueries.dropPriceConditionScaleTable);
    database.execute(SqlQueries.dropPriceConditionTypeTable);
    database.execute(SqlQueries.dropPriceScaleBasisTable);
    database.execute(SqlQueries.dropPricingAreaTable);
    database.execute(SqlQueries.dropPricingGroupsTable);
    database.execute(SqlQueries.dropPricingLevelsTable);
    database.execute(SqlQueries.dropProductQuantityTable);

    //again create new tables
    createTables(database);
  }
}
