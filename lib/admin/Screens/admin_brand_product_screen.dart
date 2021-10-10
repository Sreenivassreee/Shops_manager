import 'package:flutter/material.dart';
import 'package:shops_manager/admin/Screens/admin_same_brand_products.dart';

import 'package:shops_manager/widgets/title_text.dart';
import 'package:shops_manager/export.dart';

import 'admin_sales_report.dart';

class AdminBrandProductScreen extends StatefulWidget {
  const AdminBrandProductScreen({Key? key}) : super(key: key);

  @override
  State<AdminBrandProductScreen> createState() =>
      _AdminBrandProductScreenState();
}

class _AdminBrandProductScreenState extends State<AdminBrandProductScreen> {
  var data = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        height: MediaQuery.of(context).size.height - 210,
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: data + 3,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return data > index
                ? InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AdminSameBrandProducts(),
                        ),
                      );
                    },
                    child: new Card(
                      elevation: 0,
                      child: Center(
                        child: Text("MI +$index"),
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
