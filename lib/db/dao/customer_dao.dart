 import 'package:order_booking/db/entities/customer_input/customer_input.dart';

abstract class CustomerDao{

  Future<void> deleteAllCustomerInput();

  Future<void> insertCustomerInput(CustomerInput customerInput);
}