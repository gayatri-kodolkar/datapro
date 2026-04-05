import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/customer.dart';
import '../../domain/providers/customer_provider.dart';

class EditCustomerScreen extends StatefulWidget {
  final Customer customer;

  const EditCustomerScreen({super.key, required this.customer});

  @override
  State<EditCustomerScreen> createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController dateController;
  late TextEditingController nameController;
  late TextEditingController productController;
  late TextEditingController quantityController;
  late TextEditingController priceController;

  late String status;

  @override
  void initState() {
    super.initState();

    // Pre-fill existing data
    dateController = TextEditingController(text: widget.customer.date);
    nameController = TextEditingController(text: widget.customer.name);
    productController = TextEditingController(text: widget.customer.product);
    quantityController =
        TextEditingController(text: widget.customer.quantity.toString());
    priceController =
        TextEditingController(text: widget.customer.price.toString());

    status = widget.customer.status;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Customer"),
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

              /// Update Button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final updatedCustomer = widget.customer.copyWith(
                      date: dateController.text,
                      name: nameController.text,
                      product: productController.text,
                      quantity:
                      int.parse(quantityController.text),
                      price: double.parse(priceController.text),
                      status: status,
                    );

                    await provider.updateCustomer(updatedCustomer);

                    Navigator.pop(context);
                  }
                },
                child: const Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}