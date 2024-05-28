import 'package:order_booking/utils/sql_queries.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _databaseVersion = 3;
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
    database.execute(SqlQueries.createAssetStatusTable);
    database.execute(SqlQueries.createMarketReturnReasonTable);
    database.execute(SqlQueries.createLookUpTable);
    database.execute(SqlQueries.createMarketReturnDetailsTable);
    database.execute(SqlQueries.createMarketReturnsTable);
    database.execute(SqlQueries.createMerchandiseTable);
    database.execute(SqlQueries.createOrderTable);
    database.execute(SqlQueries.createOrderDetailTable);
    database.execute(SqlQueries.createOrderStatusTable);
    database.execute(SqlQueries.createOutletTable);
    database.execute(SqlQueries.createOutletAvailedPromotionTable);
    database.execute(SqlQueries.createPackageTable);
    database.execute(SqlQueries.createProductTable);
    database.execute(SqlQueries.createProductGroupTable);
    database.execute(SqlQueries.createPromotionTable);
    database.execute(SqlQueries.createRouteTable);
    database.execute(SqlQueries.createTaskTable);
  }

  static Future<void> upgradeTables(Database database) async {}
}
