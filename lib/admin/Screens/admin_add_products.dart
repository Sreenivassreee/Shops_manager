import 'package:shops_manager/export.dart';

import 'admin_final_alert.dart';

class AdminAddProducts extends StatefulWidget {
  var shopName;
  AdminAddProducts({Key? key, this.shopName}) : super(key: key);

  @override
  State<AdminAddProducts> createState() => _AdminAddProductsState();
}

class _AdminAddProductsState extends State<AdminAddProducts> {
  TextEditingController brand = TextEditingController();
  TextEditingController phoneModel = TextEditingController();
  TextEditingController ram = TextEditingController();
  TextEditingController storage = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();
  var error;
  Fire fire = Fire();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: btn(
          btnTitle: "Save",
          action: () async {
            if (brand.text.isEmpty ||
                phoneModel.text.isEmpty ||
                ram.text.isEmpty ||
                storage.text.isEmpty ||
                price.text.isEmpty ||
                quantity.text.isEmpty) {
              error = "Please enter valid details";
            } else {
              error = '';
              await fire.AddProductToShop(
                      shopName: widget.shopName,
                      brand: brand.text,
                      phoneModel: phoneModel.text,
                      ram: ram.text,
                      storage: storage.text,
                      price: price.text,
                      quantity: quantity.text)
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
            }
          }),
      appBar: app_bar(title: widget.shopName.toUpperCase(), actionText: "Add"),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: brand,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Brand',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: phoneModel,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone model',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: ram,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ram',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: storage,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Storage',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: price,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Price',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: quantity,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Quantity',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(error ?? "", style: TextStyle(color: Colors.red)),
            ),
          ),
          Container(height: 50)
        ],
      ),
    );
  }
}
