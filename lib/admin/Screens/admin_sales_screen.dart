import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shops_manager/admin/Screens/admin_sales_report.dart';
import 'package:shops_manager/admin/Screens/all_sales.dart';
import 'package:shops_manager/export.dart';
import 'package:shops_manager/shop/shared-pref/shop-shared-pref.dart';
import 'package:shops_manager/widgets/global/cuperLoading.dart';

class AdminSalesScreen extends StatefulWidget {
  const AdminSalesScreen({Key? key}) : super(key: key);

  @override
  State<AdminSalesScreen> createState() => _AdminSalesScreenState();
}

class _AdminSalesScreenState extends State<AdminSalesScreen> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('shops').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logout();
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
        },
        child: Icon(Icons.logout),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: TitleText(
          title: "SALES",
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
              var shopName = toBeginningOfSentenceCase(data["shop_name"]);

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
                      builder: (BuildContext context) => AllSales(
                        data: tempData = {
                          "shopName": shopName,
                          "manager": managerName
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            shopName ?? " ",
                            style: TextStyle(fontSize: 25, color: Colors.green),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                managerName != null
                                    ? "Shop Manager :   " + managerName!
                                    : "",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              // Text(
                              //   productCount,
                              //   style: TextStyle(
                              //     fontSize: 20,
                              //   ),
                              // )
                            ],
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
