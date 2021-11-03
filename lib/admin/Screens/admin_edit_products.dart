import 'package:flutter/cupertino.dart';
import 'package:shops_manager/admin/Screens/admin_final_alert.dart';
import 'package:shops_manager/export.dart';

class AdminEditProducts extends StatefulWidget {
  var shopName;
  var eachProduct;
  AdminEditProducts({Key? key, this.shopName, this.eachProduct})
      : super(key: key);

  @override
  State<AdminEditProducts> createState() => _AdminEditProductsState();
}

class _AdminEditProductsState extends State<AdminEditProducts> {
  Fire fire = Fire();
  var eachProduct;
  var brand = '';
  var error = '';
  bool isDeleted = false;
  TextEditingController phoneModel = TextEditingController();
  TextEditingController ram = TextEditingController();
  TextEditingController storage = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();

  @override
  void initState() {
    // print(widget.shopName);
    super.initState();

    brand = widget.eachProduct?['product_brand'];
    phoneModel.text = widget.eachProduct?['product_model'];
    ram.text = widget.eachProduct?['product_ram'];
    storage.text = widget.eachProduct?['product_storage'];
    price.text = widget.eachProduct?['product_price'];
    quantity.text = widget.eachProduct?['product_quantity'];
    try {
      isDeleted = widget.eachProduct?['_isDeleted'];
      // print(isDeleted);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: btn(
          btnTitle: "NEXT",
          action: () async {
            await fire.UpdateProductToShop(
                    shopName: widget.shopName,
                    brand: brand,
                    phoneModel: phoneModel.text,
                    ram: ram.text,
                    storage: storage.text,
                    price: price.text,
                    quantity: quantity.text,
                    isDeleted: isDeleted)
                .then((value) => {
                      if (value == "Done")
                        {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AdminHomepage()),
                              (route) => false)
                        }
                      else if (value == "NoShop")
                        {error = "No shop Error"}
                      else if (value == "Error")
                        {error = "Failed"}
                      else
                        {error = "Un Expected"}
                    });

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (BuildContext context) => AdminFinalAlert(),
            //   ),
            // ),
          }),
      appBar: app_bar(title: widget.shopName ?? "None", actionText: "Edit"),
      body: Container(
        padding: EdgeInsets.all(0),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(15.0),
              child: Text(
                brand,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: phoneModel,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabled: false,
                  labelText: 'Phone model',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: ram,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ram',
                  enabled: false,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: storage,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Storage',
                  enabled: false,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: price,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Price',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: quantity,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Quantity',
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("is Deleted ?"),
                    CupertinoSwitch(
                      trackColor: Colors.green,
                      activeColor: Colors.red,
                      value: isDeleted,
                      onChanged: (bool value) {
                        setState(() {
                          isDeleted = !isDeleted;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//   Widget _showDialog(BuildContext context) {
//     return CupertinoAlertDialog(
//       title: Column(
//         children: <Widget>[
//           Text("Do you want to delete"),
//         ],
//       ),
//       content: new Text(""),
//       actions: <Widget>[
//         CupertinoDialogAction(
//           child: Text("CANCEL"),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         CupertinoDialogAction(
//           child: Text(
//             "YES",
//             style: TextStyle(color: Colors.red),
//           ),
//           onPressed: () {
//             // fire.UpdateToDeleteProduct();
//             Navigator.of(context).pop();
//           },
//         ),
//       ],
//     );
//   }
// }
