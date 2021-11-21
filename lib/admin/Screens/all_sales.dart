import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shops_manager/export.dart';
import 'package:shops_manager/globalcode/date.dart';
import 'package:shops_manager/widgets/global/toast.dart';

class AllSales extends StatefulWidget {
  var data;
  AllSales({Key? key, this.data}) : super(key: key);

  @override
  State<AllSales> createState() => _AllSalesState();
}

class _AllSalesState extends State<AllSales> {
  Stream<QuerySnapshot>? productsStream;
  var shopName;
  var data;
  var d;
  var len = 0;
  var salesProductData = [];
  var date;
  var isLoading = true;
  DateTime? _selectedDate;

  var totalInternalBillingPrice = 0;

  var displayTotalInternalBillingPrice = "";
  var totalMRP = 0;
  var displayMRPToday = "";
  var displayDate = '';

  @override
  initState() {
    super.initState();
    date = revGetDate();
    displayDate = getSelectedDisplayDate(DateTime.now());
    getData();
    if (shopName == '') {
      show(context, "Something went wrong!");
    }
  }

  getData() async {
    shopName = widget.data['shopName'].toString().toLowerCase().trim();
    setState(() {
      salesProductData = [];
      totalMRP = 0;
      totalInternalBillingPrice = 0;
      displayTotalInternalBillingPrice = "";
      displayMRPToday = "";
    });
    // print(widget.data);
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
                // print(d)
              });
      d?.forEach((key, value) {
        salesProductData.add(d[key]);
      });
      if (d != null) {
        gettodayTotalSellingPrice();
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      show(context, "Error");
    }
  }

  gettodayTotalSellingPrice() {
    for (var i = 0; i < salesProductData.length; i++) {
      for (var j = 0; j < salesProductData[i].length; j++) {
        var tempPrice = salesProductData[i][j]['buy_products']
            ['now_internal_selling_price_total'];
        totalInternalBillingPrice =
            totalInternalBillingPrice + int.parse(tempPrice);
        var tempmrp = salesProductData[i][j]['buy_products']
            ['now_mrp_selling_total_price'];
        totalMRP = totalMRP + int.parse(tempmrp);
      }
      // print(totalInternalBillingPrice);
      // print(totalMRP);
    }
    displayTotalInternalBillingPrice =
        getMoney(money: totalInternalBillingPrice.toString());
    displayMRPToday = getMoney(money: totalMRP.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: InkWell(
          onTap: _pickDateDialog,
          child: Text(
            displayDate,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(displayTotalInternalBillingPrice,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                        fontWeight: FontWeight.bold)),
                Text(
                  displayMRPToday,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      // app_bar(
      //     title: getDetailsDate.toString(),
      //     actionText: displayTotalInternalBillingPrice.toString()),
      body: Center(
        child: isLoading == true
            ? CircularProgressIndicator()
            : Container(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: salesProductData.length,
                  itemBuilder: (context, mi) {
                    var innerCount = salesProductData[mi].length;
                    var h = (innerCount * 130) + 70;
                    var name = salesProductData[mi][0]['customer_details']
                            ['name']
                        .toString()
                        .toUpperCase();
                    var mobile = salesProductData[mi][0]['customer_details']
                            ['mobile']
                        .toString()
                        .toUpperCase();

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                        child: Container(
                          height: h.toDouble(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      child: Text(
                                        name[0],
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(name),
                                        SizedBox(height: 5),
                                        Text(mobile),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    primary: false,
                                    itemCount: innerCount,
                                    itemBuilder: (context, i) {
                                      var brand = salesProductData[mi][i]
                                              ['buy_products']['now_brand']
                                          .toString()
                                          .toUpperCase();
                                      var model = salesProductData[mi][i]
                                              ['buy_products']['now_model']
                                          .toString()
                                          .toUpperCase();
                                      var ram = salesProductData[mi][i]
                                              ['buy_products']['now_ram']
                                          .toString()
                                          .toUpperCase();
                                      var storage = salesProductData[mi][i]
                                              ['buy_products']['now_storage']
                                          .toString()
                                          .toUpperCase();
                                      var id = salesProductData[mi][i]
                                              ['buy_products']['now__id']
                                          .toString()
                                          .toUpperCase();
                                      var mrp = salesProductData[mi][i]
                                                  ['buy_products'][
                                              'now_mrp_selling_price_per_piece']
                                          .toString()
                                          .toUpperCase();

                                      var internalPricing = salesProductData[mi]
                                                  [i]['buy_products'][
                                              'now_internal_selling_price_per_piece']
                                          .toString()
                                          .toUpperCase();
                                      var billURL = salesProductData[mi][i]
                                              ['buy_products']['now_bill_url']
                                          .toString()
                                          .toUpperCase();
                                      var quantity = salesProductData[mi][i]
                                              ['buy_products']['now_quantity']
                                          .toString()
                                          .toUpperCase();
                                      var time = salesProductData[mi][i]
                                          ['buy_products']['now_time_stamp'];
                                      var timeStamp = getTimeStamp(time: time);
                                      var displaytime = timeStamp.split(", ");

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.black12,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          // color: Colors.indigo[50],
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
                                                          CrossAxisAlignment
                                                              .start,
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
                                                          decoration:
                                                              new BoxDecoration(
                                                            color: Colors
                                                                .indigo[50],
                                                            shape: BoxShape
                                                                .rectangle,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10.0)),
                                                            border: Border.all(
                                                                width: 1.0,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(4),
                                                          // color: Colors.indigo[50],
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
                                                          const EdgeInsets.all(
                                                              5.0),
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
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                "₹$mrp",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(displaytime[
                                                                  0]),
                                                              Text(displaytime[
                                                                  1]),
                                                            ],
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            height: 90,
                                                            width: 1.5,
                                                            color: Colors.white,
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 1),
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                CircleAvatar(
                                                                  radius: 15,
                                                                  backgroundColor:
                                                                      Colors.indigo[
                                                                          50],
                                                                  child: Text(
                                                                    "$quantity",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: SizedBox(
                                                                      height:
                                                                          10),
                                                                ),
                                                                SizedBox(
                                                                    height: 5),
                                                                Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                                2),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Share.share(
                                                                            billURL);
                                                                      },
                                                                      child: Icon(
                                                                          CupertinoIcons
                                                                              .share),
                                                                    )),
                                                                SizedBox(
                                                                    height: 5),
                                                                Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              2),
                                                                  child: Icon(
                                                                      CupertinoIcons
                                                                          .book),
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
                  },
                ),
              ),
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
      getData();
    });
  }
}
