import 'package:shops_manager/admin/Screens/admin_add_products.dart';
import 'package:shops_manager/admin/Screens/admin_edit_products.dart';
import 'package:shops_manager/export.dart';

class AdminSameBrandProducts extends StatefulWidget {
  var brand;
  var brandsData;
  AdminSameBrandProducts({Key? key, this.brand, this.brandsData})
      : super(key: key);

  @override
  State<AdminSameBrandProducts> createState() => _AdminSameBrandProductsState();
}

class _AdminSameBrandProductsState extends State<AdminSameBrandProducts> {
  var brandData = [];
  var eachBrandProducts = [];
  @override
  void initState() {
    super.initState();
    print(widget.brand);

    brandData = widget.brandsData;

    for (var i = 0; i < brandData.length; i++) {
      // print(brands);

      if (brandData[i]['product_brand'].toUpperCase() ==
          widget.brand.toUpperCase()) {
        eachBrandProducts.add(brandData[i]);
      }

      //   eachBrandProducts.add(brands
      //       .where((a) =>
      //           shopsData[i]['product_brand'].toString().toLowerCase().trim() ==
      //           a.trim())
      //       .toList());
    }
    print("Each");
    print(eachBrandProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(title: widget.brand.toUpperCase()),
      body: Container(
        height: MediaQuery.of(context).size.height - 90,
        // child: GridView.count(
        //   crossAxisCount: 2,
        //   childAspectRatio: (1 / .4),
        //   shrinkWrap: true,
        //   children: List.generate(6, (index) {
        //     return Padding(
        //       padding: const EdgeInsets.all(10.0),
        //       child: Container(
        //         color: Colors.grey[600],
        //         child: Row(
        //           children: [],
        //         ),
        //       ),
        //     );
        //   }),
        // ),
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
                eachBrandProducts[index]['products_quantity'] ?? "0";
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => AdminEditProducts(),
                  ),
                );
              },
              child: Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // "Note 4 2gb 64gb",

                        productModel +
                            "   " +
                            productRam +
                            "GB" +
                            "   " +
                            productStorage +
                            "GB",

                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Stock",
                                style: TextStyle(color: Colors.green),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.black,
                                  child: Text(productQuantity),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(productPrice + "/-"),
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
