import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shops_manager/pdf/api/pdf_api.dart';
import 'package:shops_manager/pdf/api/pdf_invoice_api.dart';
import 'package:shops_manager/pdf/model/customer.dart';
import 'package:shops_manager/pdf/model/invoice.dart';
import 'package:shops_manager/pdf/model/supplier.dart';
import 'package:shops_manager/pdf/widget/button_widget.dart';
import 'package:shops_manager/pdf/widget/title_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:number_to_words/number_to_words.dart';
import 'package:path_provider/path_provider.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  void initState() {
    super.initState();
    print(NumberToWord().convert('en-in',125000));
  }

  @override
  Widget build(BuildContext context) => Scaffold(

        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("YOYO"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleWidget(
                  icon: Icons.picture_as_pdf,
                  text: 'Generate Invoice',
                ),
                const SizedBox(height: 48),
                ButtonWidget(
                  text: 'Invoice PDF',
                  onClicked: () async {
                    final date = DateTime.now();
                    final dueDate = date.add(Duration(days: 7));
                    final invoice = Invoice(
                      supplier: Supplier(
                        name: 'Shop Name',
                        address: 'Shop address',
                        paymentInfo: 'Thank you for shopping',
                      ),
                      customer: BillCustomer(
                        mail: "Sree@gmail.com",
                        mobile: "9505501046",
                        name: 'Sreenivas K.',
                        address: 'Eduru palamaner chittor'
                      ),
                      info: InvoiceInfo(
                        date: date,
                        dueDate: dueDate,
                        description: 'My description...',
                        number: '${DateTime.now().year}-9999',
                      ),
                      items: [
                        InvoiceItem(
                          description: 'IPhone 13 Pro Max',
                          quantity: 1,
                          gst: 19,
                          unitPrice: 120000,
                          priceInWords:NumberToWord().convert('en-in',120000)
                        ),
                        InvoiceItem(
                            description: 'IPhone 13 Pro Max',
                            quantity: 2,
                            gst: 19,
                            unitPrice: 1200,
                            priceInWords:NumberToWord().convert('en-in',1200)
                        ),
                      ],
                    );

                    final pdfFile = await PdfInvoiceApi.generate(invoice);
                    PdfApi.openFile(pdfFile);
                    PdfApi.uploadFile(pdfFile);
                    // PdfApi.saveDocument(pdf: pdfFile, name: 'sree');

                  },
                ),
              ],
            ),
          ),
        ),
      );


}
