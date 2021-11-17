import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shops_manager/export.dart';
import 'package:shops_manager/global/widgets/appbar.dart';
import 'package:shops_manager/globalcode/date.dart';
import 'package:shops_manager/shop/shared-pref/shop-shared-pref.dart';
import 'package:shops_manager/widgets/global/toast.dart';
import 'package:more/more.dart';

class TodaySales extends StatefulWidget {
  const TodaySales({Key? key}) : super(key: key);

  @override
  State<TodaySales> createState() => _TodaySalesState();
}

class _TodaySalesState extends State<TodaySales> {
  Stream<QuerySnapshot>? productsStream;

  var shopName;
  var data;
  var d;
  var len = 0;
  var salesProductData = [];
  var date;
  @override
  initState() {
    super.initState();
    date = revGetDate();
    getData();
    if (shopName == '') {
      show(context, "Something went wrong!");
      logout();
    }
  }

  getData() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    shopName = p.getString('shop-name');
    print(date);
    try {
      await FirebaseFirestore.instance
          .collection('shops')
          .doc(shopName)
          .collection('sells')
          .doc(date)
          .get()
          .then((value) => {
                setState(() {
                  d = value.data();
                }),
              });
      d?.forEach((key, value) {
        salesProductData.add(d[key]);
      });

      print(salesProductData);
    } catch (e) {
      print(e);
      show(context, "Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(title: 'TODAY SALES'),
      body: Center(
        child: Container(
          alignment: Alignment.topCenter,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: salesProductData.length,
              itemBuilder: (context, mi) {
                var innerCount = salesProductData[mi].length;
                var h = (innerCount * 130) + 70;
                var name = salesProductData[0][0]['customer_details']['name'][0]
                    .toString()
                    .toUpperCase();
                var mobile = salesProductData[0][0]['customer_details']
                        ['mobile']
                    .toUpperCase();
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Card(
                    elevation: 0,
                    child: Container(
                      height: h.toDouble(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  backgroundColor: Colors.indigo[50],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(name),
                                    SizedBox(height: 10),
                                    Text(mobile),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Flexible(
                            child: Container(
                              child: ListView.builder(
                                primary: false,
                                itemCount: innerCount,
                                itemBuilder: (context, i) {
                                  var brand = salesProductData[mi][i]
                                              ['buy_products']['now_brand']
                                          .toUpperCase() ??
                                      "None";
                                  var model = salesProductData[mi][i]
                                              ['buy_products']['now_model']
                                          .toUpperCase() ??
                                      "None";
                                  var ram = salesProductData[mi][i]
                                              ['buy_products']['now_ram']
                                          .toUpperCase() ??
                                      "None";
                                  var storage = salesProductData[mi][i]
                                              ['buy_products']['now_storage']
                                          .toUpperCase() ??
                                      "None";
                                  var id = salesProductData[mi][i]
                                      ['buy_products']['now__id'];
                                  var mrp = salesProductData[mi][i]
                                                  ['buy_products']
                                              ['now_mrp_selling_price']
                                          .toUpperCase() ??
                                      "None";
                                  var internalPricing = salesProductData[mi][i]
                                                  ['buy_products']
                                              ['now_internal_selling_price']
                                          .toUpperCase() ??
                                      "None";
                                  var billURL = salesProductData[mi][i]
                                  ['buy_products']
                                  ['now_bill_url']
                                      .toUpperCase() ??
                                      "None";

                                  var quantity = salesProductData[mi][i]
                                  ['buy_products']
                                  ['now_quantity']
                                      .toUpperCase() ??
                                      "None";
                                  var time = salesProductData[mi][i]
                                      ['buy_products']['now_time_stamp'];
                                  var timeStamp = getTimeStamp(time: time);

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: Card(
                                      color: Colors.indigo[50],
                                      elevation: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0.0,
                                            left: 10.0,
                                            bottom: 0.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "$brand",
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "$model $ram $storage ",
                                                    ),
                                                    SizedBox(height: 20),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(3),
                                                      color: Colors.grey[50],
                                                      child: Text(
                                                        "$id",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            "₹$internalPricing",
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            "₹$mrp",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Text(timeStamp),
                                                        ],
                                                      ),
                                                      Container(margin: EdgeInsets.only(left: 10),
                                                        height: 90,width: 1.5,
                                                        color: Colors.white,
                                                      ),
                                                      Container(

                                                        margin: EdgeInsets.only(
                                                            left: 1),
                                                        padding:
                                                            EdgeInsets.only(left: 5),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            CircleAvatar(
                                                              radius:15,
                                                                backgroundColor: Colors.indigo[100],
                                                                child: Text("$quantity",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),),
                                                            Container(
                                                              color: Colors
                                                                  .indigo[100],
                                                              child: SizedBox(
                                                                  height: 10),
                                                            ),
                                                            SizedBox(height: 5),
                                                            Container(
                                                              padding: EdgeInsets.all(2),
                                                                color: Colors
                                                                        .indigo[
                                                                    100],

                                                                child: InkWell(
                                                                  onTap: (){
                                                                    Share.share(
                                                                        billURL ??
                                                                            "");
                                                                  },
                                                                  child: Icon(
                                                                      CupertinoIcons
                                                                          .share),
                                                                )),
                                                            SizedBox(height: 5),
                                                            Container(
                                                              padding: EdgeInsets.all(2),
                                                              child: Icon(CupertinoIcons
                                                                  .book),
                                                              color: Colors
                                                                  .indigo[
                                                              100],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
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
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
