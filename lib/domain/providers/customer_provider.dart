import 'package:flutter/material.dart';
import '../../data/models/customer.dart';
import '../services/customer_service.dart';

class CustomerProvider extends ChangeNotifier {
  bool _isPdfLoading = false;
  bool get isPdfLoading => _isPdfLoading;

  void setPdfLoading(bool value) {
    _isPdfLoading = value;
    notifyListeners();
  }


  final CustomerService _service = CustomerService();

  List<Customer> _customers = [];
  bool _isLoading = false;

  List<Customer> get customers => _customers;
  bool get isLoading => _isLoading;

  /// Load all customers
  Future<void> loadCustomers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _customers = await _service.getAllCustomers();
    } catch (e) {
      debugPrint("Error loading customers: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Add customer
  Future<void> addCustomer({
    required String date,
    required String name,
    required String product,
    required int quantity,
    required double price,
    required String status,
  }) async {
    try {
      await _service.addCustomer(
        date: date,
        name: name,
        product: product,
        quantity: quantity,
        price: price,
        status: status,
      );

      await loadCustomers(); // Refresh list
    } catch (e) {
      debugPrint("Error adding customer: $e");
    }
  }

  /// Update customer
  Future<void> updateCustomer(Customer customer) async {
    try {
      await _service.updateCustomer(customer);
      await loadCustomers();
    } catch (e) {
      debugPrint("Error updating customer: $e");
    }
  }

  /// Delete customer
  Future<void> deleteCustomer(int id) async {
    try {
      await _service.deleteCustomer(id);
      _customers.removeWhere((c) => c.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint("Error deleting customer: $e");
    }
  }
}