import 'package:flutter/material.dart';
import 'package:shops_manager/admin/Screens/admin_same_brand_products.dart';

import 'package:shops_manager/widgets/title_text.dart';
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
  var eachBrandData = [];

  @override
  void initState() {
    super.initState();
    shopsData = widget.data['products'];

    shopName = widget.data['shopName'];

    filter();
  }

  void filter() {
    for (var i = 0; i < shopsData.length; i++) {
      if (brands.contains(
              shopsData[i]['product_brand']?.toString().toLowerCase().trim()) ==
          false) {
        setState(() {
          brands.add(
              shopsData[i]['product_brand']?.toString().toLowerCase().trim());
        });
      }
    }
    // print(brands);

    // print(brands);
    // print(eachBrandData);
  }

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
      appBar: app_bar(title: 'Stock'),
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
      body: Container(
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
                                  brand: brands[index]),
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
      ),
    );
  }
}
