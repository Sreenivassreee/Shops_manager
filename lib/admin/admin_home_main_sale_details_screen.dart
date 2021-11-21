import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shops_manager/globalcode/date.dart';
import 'package:shops_manager/widgets/global/cuperLoading.dart';
import 'package:shops_manager/widgets/global/toast.dart';

class AdminHomeMainSaleDetailsScreen extends StatefulWidget {
  const AdminHomeMainSaleDetailsScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeMainSaleDetailsScreen> createState() =>
      _AdminHomeMainSaleDetailsScreenState();
}

class _AdminHomeMainSaleDetailsScreenState
    extends State<AdminHomeMainSaleDetailsScreen> {
  var yesterdaySalesInternal = 0;
  var todaySalesInternal = 0;
  var yesterdaySalesMRP = 0;
  var todaySalesMRP = 0;
  var percentage = 0.0;
  var shopsLength = 0;
  var todayProductQuantity = 0;
  DateTime dateToday = new DateTime.now();
  var todayTotalSalesInternal = 0;
  var yesterDayTotalSalesInternal = 0;
  var manager = "None";
  var shop = "None";
  var DataForCalculations;

  var date;
  var displayMRPToday = "";
  var displayDate = '';
  var isLoading = true;
  DateTime? _selectedDate;
  Color statusColor = Colors.black;
  Stream<QuerySnapshot>? _usersStream;
  @override
  void initState() {
    displayDate = getSelectedDisplayDate(DateTime.now());
    String date = dateToday.toString().substring(0, 10);
    _usersStream = FirebaseFirestore.instance
        .collection('global')
        .doc('dailyBills')
        .collection(date)
        .snapshots();

    getData();

    super.initState();
  }

  getData() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        // print(DataForCalculations);
        var temp1 = 0;
        var temp2 = 0;
        for (var i = 0; i < DataForCalculations?.length; i++) {
          temp1 = temp1 +
              int.parse(
                  DataForCalculations[i]['today_total_initernal_sales_price']);
          temp2 = temp2 +
              int.parse(DataForCalculations[i]
                  ['yesterday_total_intenal_sales_price']);
        }
        setState(() {
          todayTotalSalesInternal = temp1;
          yesterDayTotalSalesInternal = temp2;
        });
      });
    });
  }

  getChangedDateData() {
    _usersStream = FirebaseFirestore.instance
        .collection('global')
        .doc('dailyBills')
        .collection(date)
        .snapshots();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(
          padding: EdgeInsets.only(right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("${getMoney(money: todayTotalSalesInternal.toString())}",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _pickDateDialog,
                  child: Text(
                    displayDate,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  "${getMoney(money: yesterDayTotalSalesInternal.toString())}",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
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
            DataForCalculations = snapshot.data?.docs;
          }

          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 10,
              child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  try {
                    yesterdaySalesInternal =
                        int.parse(data['yesterday_total_intenal_sales_price']);
                    todaySalesInternal =
                        int.parse(data['today_total_initernal_sales_price']);

                    yesterdaySalesMRP =
                        int.parse(data['yesterday_total_mrp_sales_price']);
                    todaySalesMRP =
                        int.parse(data['today_total_mrp_sales_price']);
                    todayProductQuantity =
                        int.parse(data['today_total_products_quantity']);

                    statusColor = yesterdaySalesInternal < todaySalesInternal
                        ? Colors.green
                        : Colors.red;
                    percentage = (double.parse(todaySalesInternal.toString()) /
                        double.parse(yesterdaySalesInternal.toString()));

                    manager = data['manager-name'] ?? "None";
                    shop = data['shop-name'] ?? "None";

                    if (percentage > 1) {
                      percentage = 1.0;
                    } else if (percentage < 0) {
                      percentage = 0.0;
                    }
                  } catch (e) {
                    show(context, "Unknown Error Contact Developer");
                  }

                  return InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) => AllSales(
                      //       data: tempData = {
                      //         "shopName": shopName,
                      //         "manager": managerName
                      //       },
                      //     ),
                      //   ),
                      // );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: CircularPercentIndicator(
                                      radius: 100.0,
                                      lineWidth: 3.0,
                                      animation: true,
                                      percent: percentage,
                                      backgroundColor: Colors.transparent,
                                      animationDuration: 2300,
                                      center: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${getMoney(money: todaySalesInternal.toString())}",
                                                  style: new TextStyle(
                                                    color: statusColor,
                                                  ),
                                                ),
                                                Text(
                                                  "${getMoney(money: todaySalesMRP.toString())}",
                                                  style: new TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Center(
                                            child: Icon(
                                              yesterdaySalesInternal <
                                                      todaySalesInternal
                                                  ? CupertinoIcons
                                                      .arrowtriangle_up_fill
                                                  : CupertinoIcons
                                                      .arrowtriangle_down_fill,
                                              color: statusColor,
                                              size: 10,
                                            ),
                                          )
                                        ],
                                      ),
                                      footer: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0, bottom: 0.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              "${getMoney(money: yesterdaySalesInternal.toString())}",
                                              style:
                                                  new TextStyle(fontSize: 12),
                                            ),
                                            Text(
                                              "${getMoney(money: yesterdaySalesMRP.toString())}",
                                              style:
                                                  new TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: statusColor),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.only(left: 7.0, right: 2),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 7.0, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(shop),
                                          Text(manager),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colors.black12, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        elevation: 0,
                                        child: Container(
                                          height: 100,
                                          width: double.infinity,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                detailRow(
                                                  title: "Today Sales",
                                                  value:
                                                      "${getMoney(money: todaySalesInternal.toString())}",
                                                ),
                                                detailRow(
                                                    title: "Products",
                                                    value:
                                                        "$todayProductQuantity"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget detailRow({title, value}) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title : "),
          Text("$value"),
        ],
      ),
    );
  }

  void _pickDateDialog() {
    // print("Calling");
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime
                .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        date = revGetBillDate(pickedDate);
        displayDate = getSelectedDisplayDate(pickedDate);

        // print(pickedDate);
        // print(displayDate);
        _selectedDate = pickedDate;
        isLoading = true;
      });
      getChangedDateData();
    });
  }

  Widget smallDetailRow({title, value}) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title : "),
          Text("$value"),
        ],
      ),
    );
  }
}
