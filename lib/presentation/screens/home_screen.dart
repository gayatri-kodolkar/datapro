import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pdf/pdf_generator.dart';
import '../../domain/providers/customer_provider.dart';
import '../widgets/customer_table.dart';
import 'add_customer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    // Load data when screen starts
    Future.microtask(() =>
        Provider.of<CustomerProvider>(context, listen: false)
            .loadCustomers());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvider>(context);

    return Scaffold(
      appBar: AppBar(
    title: const Text('Customer Ledger'),
    centerTitle: true,
    actions: [
    IconButton(
    icon: const Icon(Icons.download),
      onPressed: () async {
        final provider =
        Provider.of<CustomerProvider>(context, listen: false);

        if (provider.customers.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No data to export")),
          );
          return;
        }

        provider.setPdfLoading(true);

        await PdfGenerator.generateAllCustomersPdf(provider.customers);

        provider.setPdfLoading(false);
      },
    ),
    ],
    ),

      body: Stack(
        children: [

          /// Main Content
          provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : provider.customers.isEmpty
              ? const Center(
            child: Text(
              "No data available.\nAdd your first customer!",
              textAlign: TextAlign.center,
            ),
          )
              : CustomerTable(customers: provider.customers),

          /// PDF Loading Overlay (STEP 3 ⭐)
          if (provider.isPdfLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddCustomerScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}