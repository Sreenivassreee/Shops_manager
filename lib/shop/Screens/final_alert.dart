import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:otp_screen/otp_screen.dart';

import 'package:shops_manager/shop/Customer_Firebase.dart';
import 'package:shops_manager/widgets/global/sale_product_sucess.dart';

import 'package:shops_manager/widgets/global/toast.dart';

import '/export.dart';

class FinalAlert extends StatefulWidget {
  var id;
  var eachProduct;
  var customer;
  var quantity;
  var totalPrice;
  var paymentMode;
  var customerSellingPrice;
  var internalSellingPrice;
  FinalAlert({
    Key? key,
    this.id,
    this.eachProduct,
    this.customer,
    this.quantity,
    this.totalPrice,
    this.paymentMode,
    this.customerSellingPrice,
    this.internalSellingPrice,
  }) : super(key: key);

  @override
  State<FinalAlert> createState() => _FinalAlertState();
}

class _FinalAlertState extends State<FinalAlert> {
  var productModel;
  var productRam;
  var productStorage;
  var productPrice;
  var productQuantity;
  var productBrand;
  var price;
  var cFire = CFireBase();
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'INR');
  var transactionStatus = "";
  var code = 100+Random().nextInt(1100);
  var userCode = TextEditingController();
  bool? isLoading;

  @override
  void initState() {
    isLoading = false;
    print("[Code]" + code.toString());
    productModel = widget.eachProduct['product_model'] ?? "";
    productRam = widget.eachProduct['product_ram'] ?? "0";
    productStorage = widget.eachProduct['product_storage'] ?? "0";
    productPrice = widget.eachProduct['product_price'] ?? "None";
    productQuantity = widget.eachProduct['product_quantity'] ?? "0";
    productBrand = widget.eachProduct['product_brand'] ?? "0";
    productPrice = formatCurrency.format(int.parse(productPrice));
    productPrice = productPrice.split('.');
    productPrice = productPrice[0];
    price = formatCurrency.format(int.parse(widget.totalPrice));
    price = price.split('.');
    price = price[0];
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
      isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // bottomNavigationBar: btn(
        //   btnTitle: "PAID",
        //   action: () async {
        //     // Navigator.push(
        //     //   context,
        //     //   MaterialPageRoute(
        //     //     builder: (BuildContext context) => Homepage(),
        //     //   ),
        //     // );
        //   },
        // ),

        body: (!isLoading!)
            ? Container(
                child: OtpScreen(
                  title: code.toString(),
                  subTitle: productBrand.toUpperCase() +
                      "  " +
                      toBeginningOfSentenceCase(productModel) +
                      " " +
                      productRam +
                      "GB" +
                      " " +
                      productStorage +
                      "GB" +
                      "\n\n" +
                      "  " +
                      price +
                      " /- ",
                  otpLength: 3,
                  validateOtp: validateOtp,
                  routeCallback: moveToNextScreen,
                  titleColor: Colors.black,
                  themeColor: Colors.black,
                ),
              )
            : Center(
                child: CachedNetworkImage(
                  imageUrl:
                      "https://cdn.dribbble.com/users/733202/screenshots/15793600/media/e5a416d19d4c015287dfcada0040e5fb.gif",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              )
        // ],
        // ),
        //       ),
        //     ],
        //   ),
        );
  }

  Future<String> validateOtp(String otp) async {
    if (otp == code.toString()) {
      setState(() {
        isLoading = true;
      });

      await cFire.SellProduct(
              customer: widget.customer,
              id: widget.id,
              toalPrice: price.toString(),
              quantity: widget.quantity.toString(),
              paymentMode: widget.paymentMode,
              customerSellingPrice: widget.customerSellingPrice,
              internalSellingPrice: widget.internalSellingPrice)
          .then((v) => {
                print("[TransactionCompleted]" + v),
                if (v.length >= 50)
                  {
                    print("HERE"),
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SaleProductSucess(
                                billURL: v,
                                customer: widget.customer,
                                isSucess: true)),
                        (route) => false)
                  }
                else
                  {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SaleProductSucess(
                                errorMessage: v, isSucess: false)),
                        (route) => false),
                    print("E is"),
                    print(v),
                  }
              });
      return "YES";
    } else {
      setState(() {
        isLoading = false;
      });
      return "Envalid Code";
    }
  }

  // action to be performed after OTP validation is success
  void moveToNextScreen(context) {
    print("MOVE");
    // Navigator.push(context, MaterialPageRoute(
    //     builder: (context) => SuccessfulOtpScreen()));
  }
}
