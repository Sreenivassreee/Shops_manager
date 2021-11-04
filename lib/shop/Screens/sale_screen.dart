import 'package:shops_manager/shop/Customer_Firebase.dart';
import 'package:shops_manager/shop/models/customer.dart';

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
  var CustomerName = TextEditingController();
  var CustomerSellingPrice = TextEditingController();
  var CustomerMobile = TextEditingController();
  var CustomerAddress = TextEditingController();
  var CustomerMail = TextEditingController();
  var CustomerQuantity = TextEditingController();
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
    CustomerQuantity.text = "1";
    try {
      id = productBrand.replaceAll(' ', '') +
          productModel.replaceAll(' ', '') +
          productRam.replaceAll(' ', '') +
          productStorage.replaceAll(' ', '');
    } catch (e) {}
    print(id);
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
                controller: CustomerQuantity,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Quantity => R',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: CustomerName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name => R',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: CustomerSellingPrice,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Selling price => R',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: CustomerMobile,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Whats App Number => R',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: CustomerMail,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'mail',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: CustomerAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address',
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
            if (CustomerQuantity.text.isEmpty ||
                CustomerName.text.isEmpty ||
                CustomerSellingPrice.text.isEmpty ||
                CustomerMobile.text.isEmpty) {
              setState(() {
                error = "Please provide valid Cretentials";
              });
            } else {
              customer = Customer(
                name: CustomerName.text,
                address: CustomerAddress.text,
                mail: CustomerMail.text,
                mobile: CustomerMobile.text,
              );
              var totalPrice = int.parse(CustomerSellingPrice.text) *
                  int.parse(CustomerQuantity.text);
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
                    quantity: CustomerQuantity.text.toString(),
                    totalPrice: totalPrice.toString(),
                    paymentMode: dropdownValue,
                    customerSellingPrice: CustomerSellingPrice.text.toString(),
                  ),
                ),
              );
            }
            print(customer);
            print(id);
            print(CustomerSellingPrice.text);
            print(CustomerQuantity.text);
          },
        ),
      ),
    );
  }
}
