import 'dart:io';

import 'package:intl/intl.dart';
import 'package:shops_manager/shop/Customer_Firebase.dart';

import '/export.dart';

class FinalAlert extends StatefulWidget {
  var id;
  var eachProduct;
  var customer;
  var quantity;
  var totalPrice;
  var paymentMode;
  var customerSellingPrice;
  var internalSellingPrice;
  FinalAlert({
    Key? key,
    this.id,
    this.eachProduct,
    this.customer,
    this.quantity,
    this.totalPrice,
    this.paymentMode,
    this.customerSellingPrice,
    this.internalSellingPrice,
  }) : super(key: key);

  @override
  State<FinalAlert> createState() => _FinalAlertState();
}

class _FinalAlertState extends State<FinalAlert> {
  var productModel;
  var productRam;
  var productStorage;
  var productPrice;
  var productQuantity;
  var productBrand;
  var price;
  var cFire = CFireBase();
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
    price = formatCurrency.format(int.parse(widget.totalPrice));
    price = price.split('.');
    price = price[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: btn(
        btnTitle: "PAID",
        action: () async {
          await cFire.SellProduct(
                  customer: widget.customer,
                  id: widget.id,
                  toalPrice: price.toString(),
                  quantity: widget.quantity.toString(),
                  paymentMode: widget.paymentMode,
                  customerSellingPrice: widget.customerSellingPrice,
                  internalSellingPrice: widget.internalSellingPrice)
              .then((v) => {
                    print(v),
                    if (v == "TransactionCompleted")
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Homepage(),
                          ),
                        )
                      }
                    else
                      {
                        print("E is"),
                        print(v),
                      }
                  });
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => Homepage(),
          //   ),
          // );
        },
      ),
      body: ListView(
        children: [
          TitleText(
            title: "Final Alert",
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
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
                ),
                SizedBox(height: 20),
                Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "Total Amount ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            price,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "1234",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    // controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Code',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
