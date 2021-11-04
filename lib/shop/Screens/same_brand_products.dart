import 'package:flutter/material.dart';
import 'package:shops_manager/admin/Screens/admin_edit_products.dart';

import 'package:shops_manager/widgets/title_text.dart';
import 'package:shops_manager/export.dart';

class SameBrandProducts extends StatefulWidget {
  var shopName;
  var brand;
  var brandsData;
  SameBrandProducts({Key? key, this.shopName, this.brand, this.brandsData})
      : super(key: key);

  @override
  State<SameBrandProducts> createState() => _SameBrandProductsState();
}

class _SameBrandProductsState extends State<SameBrandProducts> {
  var brandData = [];
  var eachBrandProducts = [];
  @override
  void initState() {
    super.initState();

    brandData = widget.brandsData;

    for (var i = 0; i < brandData.length; i++) {
      if (brandData[i]['product_brand'].toUpperCase() ==
          widget.brand.toUpperCase()) {
        eachBrandProducts.add(brandData[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(
          title: widget.brand.toUpperCase(), actionText: widget.shopName ?? ""),
      body: Container(
        height: MediaQuery.of(context).size.height - 90,
        child: GridView.builder(
          itemCount: eachBrandProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (1 / .6),
          ),
          itemBuilder: (BuildContext context, int index) {
            var productModel = eachBrandProducts[index]['product_model'] ?? "";
            var productRam = eachBrandProducts[index]['product_ram'] ?? "0";
            var productStorage =
                eachBrandProducts[index]['product_storage'] ?? "0";
            var productPrice =
                eachBrandProducts[index]['product_price'] ?? "None";
            var productQuantity =
                eachBrandProducts[index]['product_quantity'] ?? "0";
            var _isDeleted = false;
            try {
              _isDeleted = eachBrandProducts[index]['_isDeleted'] ?? false;
            } catch (e) {}

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ProductDetails(eachProduct: eachBrandProducts[index]),
                  ),
                );
              },
              child: Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.green[200],
                        child: Text(
                          // "Note 4 2gb 64gb",

                          productModel ?? "",
                          textAlign: TextAlign.center,

                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          productRam + "GB" + "   " + productStorage + "GB",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                productPrice + "/-",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.black,
                                  child: Text(productQuantity),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(""),
                              _isDeleted
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Container(
                                        child: CircleAvatar(
                                          radius: 4,
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink()
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
