import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/providers/customer_provider.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String status = "Unpaid";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Customer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              /// Date
              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(labelText: "Date"),
                validator: (value) =>
                value!.isEmpty ? "Enter date" : null,
              ),

              /// Name
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) =>
                value!.isEmpty ? "Enter name" : null,
              ),

              /// Product
              TextFormField(
                controller: productController,
                decoration: const InputDecoration(labelText: "Product"),
                validator: (value) =>
                value!.isEmpty ? "Enter product" : null,
              ),

              /// Quantity
              TextFormField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Quantity"),
                validator: (value) =>
                value!.isEmpty ? "Enter quantity" : null,
              ),

              /// Price
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Price"),
                validator: (value) =>
                value!.isEmpty ? "Enter price" : null,
              ),

              const SizedBox(height: 20),

              /// Status Dropdown
              DropdownButtonFormField<String>(
                value: status,
                items: ["Paid", "Unpaid"]
                    .map((s) => DropdownMenuItem(
                  value: s,
                  child: Text(s),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    status = value!;
                  });
                },
                decoration: const InputDecoration(labelText: "Status"),
              ),

              const SizedBox(height: 30),

              /// Save Button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await provider.addCustomer(
                      date: dateController.text,
                      name: nameController.text,
                      product: productController.text,
                      quantity:
                      int.parse(quantityController.text),
                      price: double.parse(priceController.text),
                      status: status,
                    );

                    Navigator.pop(context);
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}