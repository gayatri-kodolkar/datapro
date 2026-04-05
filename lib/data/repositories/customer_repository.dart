import '../local/database_helper.dart';
import '../models/customer.dart';

class CustomerRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Add new customer
  Future<int> addCustomer(Customer customer) async {
    return await _databaseHelper.insertCustomer(customer);
  }

  /// Get all customers
  Future<List<Customer>> getAllCustomers() async {
    return await _databaseHelper.getAllCustomers();
  }

  /// Update customer
  Future<int> updateCustomer(Customer customer) async {
    return await _databaseHelper.updateCustomer(customer);
  }

  /// Delete customer
  Future<int> deleteCustomer(int id) async {
    return await _databaseHelper.deleteCustomer(id);
  }
}