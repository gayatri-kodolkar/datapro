import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pdf/pdf_generator.dart';
import '../../data/models/customer.dart';
import '../../domain/providers/customer_provider.dart';
import '../screens/edit_customer_screen.dart';

class CustomerRow {
  static DataRow buildRow(BuildContext context, Customer customer) {
    return DataRow(
      cells: [
        DataCell(Text(customer.date)),
        DataCell(Text(customer.name)),
        DataCell(Text(customer.product)),
        DataCell(Text(customer.quantity.toString())),
        DataCell(Text(customer.price.toStringAsFixed(2))),
        DataCell(Text(customer.total.toStringAsFixed(2))),

        /// Status
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: customer.status == "Paid"
                  ? Colors.green.shade100
                  : Colors.red.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              customer.status,
              style: TextStyle(
                color: customer.status == "Paid"
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        /// Actions (Edit + Delete)
        DataCell(
          Row(
            children: [
              /// Edit Button
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          EditCustomerScreen(customer: customer),
                    ),
                  );
                },
              ),

              /// Delete Button
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  final confirm = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Confirm Delete"),
                      content: const Text(
                          "Are you sure you want to delete this record?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    Provider.of<CustomerProvider>(context, listen: false)
                        .deleteCustomer(customer.id!);
                  }
                },
              ),

              IconButton(
                icon: const Icon(Icons.picture_as_pdf, color: Colors.green),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Generating Invoice...")),
                  );

                  PdfGenerator.generateCustomerPdf(customer);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}