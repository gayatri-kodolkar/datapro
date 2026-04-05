import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/providers/customer_provider.dart';
import '../../data/models/customer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvider>(context);
    final List<Customer> customers = provider.customers;

    // Calculations
    double totalRevenue = 0;
    double unpaidAmount = 0;

    for (var c in customers) {
      totalRevenue += c.total;

      if (c.status == "Unpaid") {
        unpaidAmount += c.total;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// Total Revenue Card
            _buildCard(
              title: "Total Revenue",
              value: "₹ ${totalRevenue.toStringAsFixed(2)}",
              color: Colors.green,
            ),

            const SizedBox(height: 16),

            /// Unpaid Amount Card
            _buildCard(
              title: "Unpaid Amount",
              value: "₹ ${unpaidAmount.toStringAsFixed(2)}",
              color: Colors.red,
            ),

            const SizedBox(height: 16),

            /// Total Customers
            _buildCard(
              title: "Total Customers",
              value: customers.length.toString(),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable Card Widget
  Widget _buildCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                fontSize: 16,
                color: color,
              )),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}