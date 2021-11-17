import 'package:flutter/material.dart';
import 'package:shops_manager/admin/Screens/admin_same_brand_products.dart';

import 'package:shops_manager/export.dart';

import 'admin_sales_report.dart';

class AdminStockProductScreen extends StatefulWidget {
  var data;
  AdminStockProductScreen({Key? key, this.data}) : super(key: key);

  @override
  State<AdminStockProductScreen> createState() =>
      _AdminStockProductScreenState();
}

class _AdminStockProductScreenState extends State<AdminStockProductScreen> {
  var dataLength = 0;
  var shopsData;
  var shopName = '';
  var brands = [];
  var temp = [];
  var eachBrandData = [];
  Stream<QuerySnapshot>? AdminProductsStream;

  @override
  void initState() {
    super.initState();
    brands = [];
    shopName = widget.data['shopName'];
    set();
    AdminProductsStream = FirebaseFirestore.instance
        .collection('shops')
        .doc(shopName)
        .collection('products')
        .snapshots();
  }

  void set() {
    if (shopName.length > 0) {
    } else {
      //print("NO Shop Name");
    }
  }

  // void filter(docs) {
  ////   print(docs[0]['product_brand']);
  ////   print(temp);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  AdminAddProducts(shopName: shopName),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: app_bar(title: 'Stock', actionText: shopName),
      bottomSheet: btn(
        btnTitle: "SELES",
        action: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AdminSalesReport(),
            ),
          );
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: AdminProductsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            var docs = snapshot.data?.docs;
            shopsData = docs;
            //// print(docs!.length);
            var tempAllBrands = [];
            var tempBrands = [];
            try {
              for (var i = 0; i < docs!.length; i++) {
                var brd = docs[i]['product_brand'];
                tempAllBrands.add(brd);
              }
              //print(tempAllBrands);
              for (var i = 0; i < tempAllBrands.length; i++) {
                //print(tempAllBrands[i]);
                if (tempBrands.contains(
                      tempAllBrands[i].toString().toLowerCase().trim(),
                    ) ==
                    false) {
                  tempBrands.add(
                    tempAllBrands[i].toString().toLowerCase().trim(),
                  );
                }
              }
              brands = tempBrands;
            } catch (e) {
              //print("[Error in AdminStockProductScreen => 112]");
            }
          }

          return Container(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: brands.length + 3,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return brands.length > index
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AdminSameBrandProducts(
                                shopName: shopName,
                                brandsData: shopsData,
                                brand: brands[index],
                              ),
                            ),
                          );
                        },
                        child: new Card(
                          elevation: 0,
                          child: Center(
                            child: Text(brands[index] ?? ""),
                          ),
                        ),
                      )
                    : Container(
                        child: SizedBox(
                          height: 100,
                        ),
                      );
              },
            ),
          );
        },
      ),
    );
  }
}
