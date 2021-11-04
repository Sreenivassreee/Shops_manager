import '/export.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class ProductDetails extends StatefulWidget {
  var eachProduct;
  ProductDetails({Key? key, this.eachProduct}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var productModel;
  var productRam;
  var productStorage;
  var productPrice;
  var productQuantity;
  var productBrand;

  final formatCurrency =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'INR');
  @override
  void initState() {
    super.initState();
    productModel = widget.eachProduct['product_model'] ?? "";
    productRam = widget.eachProduct['product_ram'] ?? "0";
    productStorage = widget.eachProduct['product_storage'] ?? "0";
    productPrice = widget.eachProduct['product_price'] ?? "None";
    productQuantity = widget.eachProduct['product_quantity'] ?? "0";
    productBrand = widget.eachProduct['product_brand'] ?? "0";
    productPrice = formatCurrency.format(int.parse(productPrice));
    productPrice = productPrice.split('.');
    productPrice = productPrice[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(
          title: productModel.toUpperCase(),
          actionText: productQuantity + "   "),
      bottomSheet: Container(
        height: 120,
        child: Column(
          children: [
            btn(
              btnTitle: "SELE",
              action: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        SalePage(eachProduct: widget.eachProduct),
                  ),
                );
              },
            ),
            tBtn(
              btnTitle: "SEND TO ANOTHER STORE",
              action: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SendToAnotherShop(),
                  ),
                );
              },
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Brand : " + productBrand.toUpperCase(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Model : " + productModel.toUpperCase(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Ram : " + productRam.toUpperCase() + " GB",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Storage : " + productStorage.toUpperCase() + " GB",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "MRP : " + productPrice.toUpperCase() + " /-",
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
                Text(
                  "Available Stock : " + productQuantity.toUpperCase(),
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
