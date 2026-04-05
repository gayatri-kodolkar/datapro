class Customer {
  final int? id;
  final String date;
  final String name;
  final String product;
  final int quantity;
  final double price;
  final double total;
  final String status;

  Customer({
    this.id,
    required this.date,
    required this.name,
    required this.product,
    required this.quantity,
    required this.price,
    required this.total,
    required this.status,
  });

  /// Convert Customer object to Map (for database insertion)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'name': name,
      'product': product,
      'quantity': quantity,
      'price': price,
      'total': total,
      'status': status,
    };
  }

  /// Convert Map (from database) to Customer object
  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      date: map['date'],
      name: map['name'],
      product: map['product'],
      quantity: map['quantity'],
      price: map['price'],
      total: map['total'],
      status: map['status'],
    );
  }

  /// Optional: copyWith (useful for editing data)
  Customer copyWith({
    int? id,
    String? date,
    String? name,
    String? product,
    int? quantity,
    double? price,
    double? total,
    String? status,
  }) {
    return Customer(
      id: id ?? this.id,
      date: date ?? this.date,
      name: name ?? this.name,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      total: total ?? this.total,
      status: status ?? this.status,
    );
  }
}