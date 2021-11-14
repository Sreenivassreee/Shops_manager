import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:shops_manager/export.dart';
import 'package:shops_manager/shop/models/cus.dart';
import 'package:shops_manager/widgets/global/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class SaleProductSucess extends StatefulWidget {
  bool isSucess;
  String? billURL;
  String? errorMessage;
  Customer? customer;
  SaleProductSucess(
      {Key? key,
      required this.isSucess,
      this.billURL,
      this.errorMessage,
      this.customer})
      : super(key: key);

  @override
  State<SaleProductSucess> createState() => _SaleProductSucessState();
}

class _SaleProductSucessState extends State<SaleProductSucess> {
  String? billMessageToCustomer;

  void initState() {
    billMessageToCustomer = widget.billURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: btn(
          btnTitle: "DONE",
          action: () async {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => Homepage()),
                (route) => false);
          }),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(40),
              height: MediaQuery.of(context).size.width / 1.4,
              width: MediaQuery.of(context).size.width / 1.4,
              child: (widget.isSucess == true)
                  ? Hero(
                      tag: "Loading",
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/Assets%2F68994-success%20(1).gif?alt=media&token=e110a585-2a34-47b3-9189-61134eea15f5",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )
                  : Hero(
                      tag: "Loading",
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://firebasestorage.googleapis.com/v0/b/shop-manger.appspot.com/o/Assets%2F56947-icon-failed.gif?alt=media&token=ef829bd5-ab3e-4019-a46d-75fdfa3dd337",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
            ),
            (widget.isSucess == true)
                ? Text(
                    "Transaction successful",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    "Transaction failed",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            SizedBox(height: 20),
            (widget.isSucess == false)
                ? Card(
                    elevation: 0.0,
                    color: Colors.blueGrey[50],
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        widget.errorMessage ?? "",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            SizedBox(height: 30),
            (widget.isSucess == true)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SucessInfoCard(
                          icon: Icons.copy,
                          title: "Copy URL",
                          tap: () async {
                            await Clipboard.setData(
                                ClipboardData(text: billMessageToCustomer));
                            show(context, "Copied");
                          }),
                      SucessInfoCard(
                          icon: Icons.mobile_screen_share,
                          title: "WhatsApp",
                          tap: () async {
                            print("WhatsAp");
                            await launch(
                                "https://wa.me/${widget.customer?.mobile}?text=${billMessageToCustomer}");
                          }),
                      SucessInfoCard(
                        icon: Icons.share,
                        title: "Share",
                        tap: () {
                          Share.share(billMessageToCustomer ?? "");
                        },
                      ),
                    ],
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Widget SucessInfoCard({icon, title, tap}) {
    return InkWell(
      onTap: tap,
      child: Container(
        height: 70,
        width: 90,
        child: Card(
          color: Colors.blueGrey[50],
          elevation: 0.0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 20,
                ),
                SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
