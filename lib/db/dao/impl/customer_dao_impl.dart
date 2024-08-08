import 'package:order_booking/db/dao/customer_dao.dart';
import 'package:sqflite/sqflite.dart';

import '../../entities/customer_input/customer_input.dart';

class CustomerDaoImpl extends CustomerDao {
  final Database _database;

  CustomerDaoImpl(this._database);

  @override
  Future<void> deleteAllCustomerInput() async {
    _database.rawQuery("DELETE FROM CustomerInput");
  }

  @override
  Future<void> insertCustomerInput(CustomerInput customerInput) async {
    _database.insert("CustomerInput", customerInput.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
