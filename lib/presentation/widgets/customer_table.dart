import 'package:flutter/material.dart';
import '../../data/models/customer.dart';
import 'customer_row.dart';

class CustomerTable extends StatelessWidget {
  final List<Customer> customers;

  const CustomerTable({super.key, required this.customers});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Horizontal scroll like Excel
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columnSpacing: 20,
          headingRowColor:
          MaterialStateProperty.all(Colors.blue.shade100),
          columns: const [
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Product')),
            DataColumn(label: Text('Qty')),
            DataColumn(label: Text('Price')),
            DataColumn(label: Text('Total')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Actions')),
          ],
          rows: customers
              .map(
                (customer) => CustomerRow.buildRow(context, customer),
          )
              .toList(),
        ),
      ),
    );
  }
}