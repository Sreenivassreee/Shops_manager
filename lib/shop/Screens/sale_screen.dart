import 'package:shops_manager/shop/Customer_Firebase.dart';
import 'package:shops_manager/shop/models/cus.dart';

import '/export.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class SalePage extends StatefulWidget {
  var eachProduct;
  SalePage({Key? key, this.eachProduct}) : super(key: key);

  @override
  State<SalePage> createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  var productModel;
  var productRam;
  var productStorage;
  var productPrice;
  var productQuantity;
  var productBrand;
  var cFire = CFireBase();
  var customerName = TextEditingController();
  var customerSellingPrice = TextEditingController();
  var customerMobile = TextEditingController();
  var customerAddress = TextEditingController();
  var customerMail = TextEditingController();
  var customerQuantity = TextEditingController();
  var internalSellingPrice = TextEditingController();
  var error = "";
  var customer;
  var id;
  String dropdownValue = 'CASH';

  final formatCurrency =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'INR');
  @override
  void initState() {
    productModel = widget.eachProduct['product_model'] ?? "";
    productRam = widget.eachProduct['product_ram'] ?? "0";
    productStorage = widget.eachProduct['product_storage'] ?? "0";
    productPrice = widget.eachProduct['product_price'] ?? "None";
    productQuantity = widget.eachProduct['product_quantity'] ?? "0";
    productBrand = widget.eachProduct['product_brand'] ?? "0";

    productPrice = formatCurrency.format(int.parse(productPrice));
    productPrice = productPrice.split('.');
    productPrice = productPrice[0];
    customerQuantity.text = "1";
    try {
      id = productBrand.replaceAll(' ', '') +
          productModel.replaceAll(' ', '') +
          productRam.replaceAll(' ', '') +
          productStorage.replaceAll(' ', '');
    } catch (e) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(
                  title: "Sale",
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productBrand.toUpperCase() +
                            "  " +
                            toBeginningOfSentenceCase(productModel) +
                            " " +
                            productRam +
                            "GB" +
                            " " +
                            productStorage +
                            "GB",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        productPrice,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "CUSTOMER DETAILS",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: customerQuantity,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Quantity         R',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: customerName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name         R',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: customerSellingPrice,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Selling price         R',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: customerMobile,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Whats App Number         R',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: customerMail,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'mail',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: customerAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Container(
                color: Colors.green[100],
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: internalSellingPrice,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Internal price         R',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  underline: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['CASH', 'CARD', 'PHONE PAY', 'G PAY', "EMI"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            )
          ]),
        ),
      ),
      bottomSheet: Container(
        child: btn(
          btnTitle: "CONFORM ORDER",
          action: () {
            if (customerQuantity.text.isEmpty ||
                customerName.text.isEmpty ||
                customerSellingPrice.text.isEmpty ||
                customerMobile.text.isEmpty ||
                internalSellingPrice.text.isEmpty) {
              setState(() {
                error = "Please provide valid Cretentials";
              });
            } else {
              customer = Customer(
                name: customerName.text,
                address: customerAddress.text,
                mail: customerMail.text,
                mobile: customerMobile.text,
              );
              var totalPrice = int.parse(customerSellingPrice.text) *
                  int.parse(customerQuantity.text);
              // print(customer);
              // print(id);
              // print(CustomerSellingPrice.text);
              // print(CustomerQuantity.text);
              // print(price);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => FinalAlert(
                    id: id,
                    eachProduct: widget.eachProduct,
                    customer: customer,
                    quantity: customerQuantity.text.toString(),
                    totalPrice: totalPrice.toString(),
                    paymentMode: dropdownValue,
                    customerSellingPrice: customerSellingPrice.text.toString(),
                    internalSellingPrice: internalSellingPrice.text.toString(),
                  ),
                ),
              );
            }
            // print(customer);
            // print(id);
            // print(customerSellingPrice.text);
            // print(customerQuantity.text);
          },
        ),
      ),
    );
  }
}
