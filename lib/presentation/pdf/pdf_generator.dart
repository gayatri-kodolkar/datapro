import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import '../../data/models/customer.dart';

class PdfGenerator {

  /// Generate PDF for single customer (Invoice)
  static Future<void> generateCustomerPdf(Customer customer) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Padding(
          padding: const pw.EdgeInsets.all(20),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [

              pw.Text("Customer Invoice",
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),

              pw.SizedBox(height: 20),

              pw.Text("Date: ${customer.date}"),
              pw.Text("Name: ${customer.name}"),
              pw.Text("Product: ${customer.product}"),

              pw.SizedBox(height: 10),

              pw.Text("Quantity: ${customer.quantity}"),
              pw.Text("Price: ₹ ${customer.price.toStringAsFixed(2)}"),
              pw.Text("Total: ₹ ${customer.total.toStringAsFixed(2)}"),

              pw.SizedBox(height: 10),

              pw.Text("Status: ${customer.status}",
                  style: pw.TextStyle(
                    color: customer.status == "Paid"
                        ? PdfColor.fromInt(0xFF00AA00)
                        : PdfColor.fromInt(0xFFAA0000),
                  )),
            ],
          ),
        ),
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

  /// Generate PDF for all customers (Report)
  static Future<void> generateAllCustomersPdf(
      List<Customer> customers) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [

          pw.Text("Customer Report",
              style: pw.TextStyle(
                  fontSize: 24, fontWeight: pw.FontWeight.bold)),

          pw.SizedBox(height: 20),

          pw.Table.fromTextArray(
            headers: [
              "Date",
              "Name",
              "Product",
              "Qty",
              "Price",
              "Total",
              "Status"
            ],
            data: customers.map((c) {
              return [
                c.date,
                c.name,
                c.product,
                c.quantity.toString(),
                c.price.toStringAsFixed(2),
                c.total.toStringAsFixed(2),
                c.status,
              ];
            }).toList(),
          ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}