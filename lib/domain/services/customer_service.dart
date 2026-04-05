import '../../data/models/customer.dart';
import '../../data/repositories/customer_repository.dart';

class CustomerService {
  final CustomerRepository _repository = CustomerRepository();

  /// Add customer with business logic
  Future<int> addCustomer({
    required String date,
    required String name,
    required String product,
    required int quantity,
    required double price,
    required String status,
  }) async {
    // Validation
    if (name.isEmpty || product.isEmpty) {
      throw Exception("Name and Product cannot be empty");
    }

    if (quantity <= 0 || price <= 0) {
      throw Exception("Quantity and Price must be greater than 0");
    }

    // Business logic: calculate total
    final double total = quantity * price;

    // Create Customer object
    final customer = Customer(
      date: date,
      name: name,
      product: product,
      quantity: quantity,
      price: price,
      total: total,
      status: status,
    );

    // Save to database via repository
    return await _repository.addCustomer(customer);
  }

  /// Get all customers
  Future<List<Customer>> getAllCustomers() async {
    return await _repository.getAllCustomers();
  }

  /// Update customer with recalculation
  Future<int> updateCustomer(Customer customer) async {
    if (customer.name.isEmpty || customer.product.isEmpty) {
      throw Exception("Name and Product cannot be empty");
    }

    if (customer.quantity <= 0 || customer.price <= 0) {
      throw Exception("Quantity and Price must be greater than 0");
    }

    // Recalculate total
    final updatedCustomer = customer.copyWith(
      total: customer.quantity * customer.price,
    );

    return await _repository.updateCustomer(updatedCustomer);
  }

  /// Delete customer
  Future<int> deleteCustomer(int id) async {
    return await _repository.deleteCustomer(id);
  }
}