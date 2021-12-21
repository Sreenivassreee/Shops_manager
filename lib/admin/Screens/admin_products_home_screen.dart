import 'package:flutter/cupertino.dart';
import 'package:shops_manager/export.dart';
import 'package:shops_manager/shop/shared-pref/shop-shared-pref.dart';
import 'package:shops_manager/widgets/global/cuperLoading.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AdminProductsHomeScreen extends StatefulWidget {
  const AdminProductsHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminProductsHomeScreen> createState() =>
      _AdminProductsHomeScreenState();
}

class _AdminProductsHomeScreenState extends State<AdminProductsHomeScreen> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('shops').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: TitleText(
          title: "PRODUCTS",
        ),
        // actions: [
        //   Container(
        //     margin: EdgeInsets.all(10),
        //     child: CircleAvatar(
        //       child: IconButton(
        //         onPressed: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (_) => AdminAddShop(),
        //             ),
        //           );
        //         },
        //         icon: Icon(Icons.add),
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return cuperLoading();
          }
          if (snapshot.hasData) {
            // print(snapshot.data?.docs[0]['products'][0]['product_ram']);
            // print("Data");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              var products;
              var productCount = "0";
              var managerName = data['user_name'];
              var shopName = data["shop_name"];
              // print(data);
              // if (data["products"]?.length != null) {
              //   var len = data["products"]?.length;
              //   print(data);
              //   // products = data.products;
              //   productCount = len.toString();
              // }

              var tempData = {
                "shopName": shopName,
                "products": products,
                "manager": managerName
              };

              // print("products");

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AdminStockProductScreen(
                        data: tempData = {
                          "shopName": shopName,
                          "manager": managerName
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                  child: Card(
                    elevation: 0,
                    child: Padding(
                             padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
 Text(
                            shopName ?? " ",
                            style: TextStyle(fontSize: 25, color: Colors.green),
                          ), 
                          SizedBox(height:10),
                          Text(
                            managerName ?? " ",
                            
                          ),
                            ]
                          ),
                         
                           Container(
                             
                                    height: 70,
                                    width: 70,
                                    child: CachedNetworkImage(
                                      imageUrl: "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/Assets%2Fproducts.jpg?alt=media&token=915b64a0-a5f6-4d22-8b7d-e81150e541e7" ,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              SizedBox(),
                                      errorWidget: (context, url, error) =>
                                          SizedBox.shrink(),
                                    ),
                                  ),
                        
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

          
          
//           ListView.builder(
//             itemCount: 50,
//             itemBuilder: (BuildContext context, int index) {
//               return InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (BuildContext context) =>
//                           AdminBrandProductScreen(),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
//                   child: Card(
//                     elevation: 0,
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "ABC Shop ${index}",
//                             style: TextStyle(fontSize: 25, color: Colors.green),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             "Shop Manager : Sreenivas K",
//                             style: TextStyle(
//                               fontSize: 15,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
