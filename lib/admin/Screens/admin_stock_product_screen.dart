import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shops_manager/admin/Screens/admin_same_brand_products.dart';

import 'package:shops_manager/export.dart';
import 'package:shops_manager/shop/models/brand.dart';
import 'package:shops_manager/widgets/global/toast.dart';

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

  var brandLogos = {
    "apple":
        "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/icons%2Fapple.png?alt=media&token=4daf0d67-e65f-4501-8190-10783e78e44b",
    "mi":
        "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/icons%2Fxiaomi-33319.png?alt=media&token=dc3da95f-4007-42ad-b08e-f8b2da997d2e",
    "vivo":
        "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/icons%2Fvivo.png?alt=media&token=7b20e654-67c6-40c1-8b14-fc9b85670575",
    "jio":
        "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/icons%2FJio-Logo-PNG.png?alt=media&token=6e6a3e60-f105-4cb8-9368-ccd77f22e922",
    "realme":
        "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/icons%2FRealme%20Logo%20(PNG720p)%20-%20Vector69Com.png?alt=media&token=40dce9a9-c02f-4531-a8d0-f7bdab6c938f",
    "asus":
        "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/icons%2Fasus.png?alt=media&token=f8d48777-0aad-4469-861a-8b445c2a684e",
    "blackberry":
        "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/icons%2Fbbm.png?alt=media&token=f3bdf964-7084-4ac5-a316-09462da3ef52",
    "htc":
        "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/icons%2Fhtc.png?alt=media&token=2bf65bec-2961-4e43-8be3-7787a0438d8a",
    "lenovo":
        "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/icons%2Flenovo.png?alt=media&token=6a32afd8-57c4-475b-a737-cb2f499af6cd",
    "lg":
        "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/icons%2Flg.png?alt=media&token=3d85eef2-76ad-4395-9c13-1c65dfc1fa51",
    "motorola":
        "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/icons%2Fmotorola.png?alt=media&token=993c1474-f426-4d9b-8e1e-0a3905d1b819",
    "nokia":
        "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/icons%2Fnokia.png?alt=media&token=1a880bb9-b946-4c31-9db3-6d76a2a7b087",
    'oppo':
        "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/icons%2Foppo-logo-40750.png?alt=media&token=044f8bc8-116c-47b1-b837-94c3a0d19a80",
    'poco':
        "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/icons%2Fpoco-by-xiaomi-logo-AA2F5D33FE-seeklogo.com.png?alt=media&token=fa4ef0bc-228f-4049-8cd1-413365242e26",
    "samsung":
        "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/icons%2Fsamsung.png?alt=media&token=0c8d80b4-a9ee-4477-81e3-2ba3dd62549a",
    "sony":
        "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/icons%2Fsony.png?alt=media&token=9ded7549-5d80-4143-a36d-b8ac76c5e4b0",
    'karbon':
        "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/icons%2Fkarbonn-mobiles-logo.png?alt=media&token=22c4d964-3e3a-42eb-b5d0-b0120ed98c19",
    'carbon':
        "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/icons%2Fkarbonn-mobiles-logo.png?alt=media&token=22c4d964-3e3a-42eb-b5d0-b0120ed98c19"
  };

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
      appBar: app_bar(title: 'BRANDS', actionText: shopName),
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
            var tempAllBrands = [];
            var tempBrands = [];
            try {
              for (var i = 0; i < docs!.length; i++) {
                var brd = docs[i]['product_brand'];
                tempAllBrands.add(brd);
              }
              for (var i = 0; i < tempAllBrands.length; i++) {
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
              show(context, "Something went wrong");
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    child: CachedNetworkImage(
                                      imageUrl: brandLogos[brands[index]] ?? "",
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          SizedBox.shrink(),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Center(
                                    child: Text(
                                      brands[index].toUpperCase() ?? "",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                            )

                            // Center(
                            //   child: Text(brands[index] ?? ""),
                            // ),
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
