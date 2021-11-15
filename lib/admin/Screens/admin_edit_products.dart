import 'package:flutter/cupertino.dart';
import 'package:shops_manager/admin/Screens/admin_final_alert.dart';
import 'package:shops_manager/export.dart';
import 'package:shops_manager/widgets/global/cuperLoading.dart';
import 'package:shops_manager/widgets/global/toast.dart';

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
  var beforeUpdateQuantity;
  var beforeUpdatePrice;
  bool isDeleted = false;
  var isLoading = false;
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
    beforeUpdateQuantity = widget.eachProduct?['product_quantity'];
    beforeUpdatePrice = widget.eachProduct?['product_price'];

    try {
      isDeleted = widget.eachProduct?['_isDeleted'];
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading == true)
        ? Scaffold(body: cuperLoading())
        : Scaffold(
            bottomSheet: btn(
                btnTitle: "NEXT",
                action: () async {
                  setState(() {
                    isLoading = true;
                  });
                  print("[price.text.isNotEmpty]" +
                      (!price.text.isNotEmpty).toString());
                  print("[quantity.text.isNotEmpty]" +
                      (!quantity.text.isNotEmpty).toString());
                  if (!price.text.isNotEmpty || !quantity.text.isNotEmpty) {
                    show(context, "Invalid info needed");
                    setState(() {
                      isLoading = false;
                    });
                  } else {
                    await fire.UpdateProductToShop(
                            shopName: widget.shopName,
                            brand: brand,
                            phoneModel: phoneModel.text,
                            ram: ram.text,
                            storage: storage.text,
                            price: price.text,
                            quantity: quantity.text,
                            beforeUpdateQuantity: beforeUpdateQuantity,
                            beforeUpdatePrice: beforeUpdatePrice,
                            isDeleted: isDeleted)
                        .then((value) => {
                              if (value == "Done")
                                {
                                  setState(() {
                                    isLoading = false;
                                  }),
                                  show(context, "Updated"),
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AdminHomepage(),
                                      ),
                                      (route) => false)
                                }
                              else if (value == "NoShop")
                                {
                                  setState(() {
                                    isLoading = false;
                                  }),
                                  error = "No shop Error",
                                  show(context, error)
                                }
                              else if (value == "Error")
                                {
                                  setState(() {
                                    isLoading = false;
                                  }),
                                  error = "Failed",
                                  show(context, error)
                                }
                              else
                                {
                                  setState(() {
                                    isLoading = false;
                                  }),
                                  error = "Un Expected",
                                  show(context, error)
                                }
                            });
                  }
                }),
            appBar:
                app_bar(title: widget.shopName ?? "None", actionText: "Edit"),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 18),
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
