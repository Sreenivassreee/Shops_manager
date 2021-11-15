import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shops_manager/globalcode/date.dart';
import 'package:shops_manager/pdf/api/pdf_api.dart';
import 'package:shops_manager/pdf/api/pdf_invoice_api.dart';
import 'package:shops_manager/pdf/model/customer.dart';
import 'package:shops_manager/pdf/model/invoice.dart';
import 'package:shops_manager/pdf/model/supplier.dart';
import 'package:shops_manager/shop/models/cus.dart';

class CFireBase {
  CollectionReference shops = FirebaseFirestore.instance.collection('shops');
  var date = getDate();
  SellProduct(
      {customer,
      id,
      toalPrice,
      quantity,
      paymentMode,
      customerSellingPrice,
      internalSellingPrice}) async {
    //print(id);
    //print(customer);
    //print(quantity);
    //print(toalPrice);
    var status = "";
    SharedPreferences p = await SharedPreferences.getInstance();

    var shop = p.getString('shop-name');
    await shops
        .doc(shop)
        .collection("products")
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        DateTime dateToday = new DateTime.now();
        String date = dateToday.toString().substring(0, 10);
        //print(date);
        var productModel = documentSnapshot['product_model'] ?? "";
        var productRam = documentSnapshot['product_ram'] ?? "0";
        var productStorage = documentSnapshot['product_storage'] ?? "0";
        var productPrice = documentSnapshot['product_price'] ?? "None";
        var productQuantity = documentSnapshot['product_quantity'] ?? "0";
        var productBrand = documentSnapshot['product_brand'] ?? "0";
        var lastUpdated = documentSnapshot['_last_updated'] ?? "None";
        var isDeleted = false;
        try {
          isDeleted = documentSnapshot['_isDeleted'];
        } catch (e) {
          status = "isDeleted Error";
          //print("Error");
        }
        try {
          lastUpdated = lastUpdated[lastUpdated.length - 1];
        } catch (e) {
          status = "lastUpdated Error ";
          //print("Error");
        }
        if (isDeleted == false) {
          if (int.parse(productQuantity) > 0) {
            if (int.parse(productQuantity) >= int.parse(quantity)) {
              await GenerateBill(
                      customer: customer,
                      id: id,
                      toalPrice: toalPrice,
                      quantity: quantity,
                      paymentMode: paymentMode,
                      customerSellingPrice: customerSellingPrice,
                      internalSellingPrice: internalSellingPrice,
                      documentSnapshot: documentSnapshot)
                  .then((generateBillReturn) async => {
                        print("[CustomerFirebse 103 Value]" +
                            generateBillReturn.toString()),
                        if (generateBillReturn.toString().length >= 20)
                          {
                            await AfterSellingUpdateQuantity(
                                    id: id,
                                    sellingQuantity: quantity,
                                    productQuantity: productQuantity,
                                    quantity: int.parse(productQuantity) -
                                        int.parse(quantity),
                                    customer: customer)
                                .then(
                              (afterSellingUpdateQuantityReturn) async => {
                                if (afterSellingUpdateQuantityReturn == "Done")
                                  {
                                    status = "AfterSellingUpdate",
                                    await shops
                                        .doc(shop)
                                        .collection('sells')
                                        .doc(date)
                                        .set({
                                      customer.mobile: FieldValue.arrayUnion([
                                        {
                                          "customer_details": {
                                            "name": customer.name,
                                            "mobile": customer.mobile,
                                            "mail": customer.mail,
                                            "address": customer.address,
                                          },
                                          "buy_products": {
                                            "now_mrp_selling_price":
                                                customerSellingPrice,
                                            "now_payment_mode": paymentMode,
                                            "now_total_price": toalPrice,
                                            "now_sell_by_manager":
                                                "sell_by_manager",
                                            "now_time_stamp": DateTime.now(),
                                            "now_storage": productStorage,
                                            "now_sell_by_shop": shop,
                                            "now_quantity": quantity,
                                            "now_model": productModel,
                                            "now__id": id,
                                            "now_bill_url": generateBillReturn,
                                            "now_brand": productBrand,
                                            "now_ram": productRam,
                                            "now_internal_selling_price":
                                                internalSellingPrice
                                          },
                                          "_past_product_details": {
                                            "_past_quantity": productQuantity,
                                            "_past_last_updated": lastUpdated,
                                            "_past_model": productModel,
                                            "_past_storage": productStorage,
                                            "_past_brand": productBrand,
                                            "_past_ram": productRam,
                                          },
                                        }
                                      ])
                                    }, SetOptions(merge: true)).then(
                                      (value) => {status = generateBillReturn},
                                    )
                                  }
                                else
                                  {status = afterSellingUpdateQuantityReturn}
                              },
                            )
                          }
                        else
                          {status = "Error Uploading the pdf"}
                      });
            } else {
              //print("Here");
              status = "Required Stock Not Available";
            }
          } else {
            status = "No Stock Available";
          }
        } else {
          status = "Item Deleted";
        }
      } else {
        status = "Invalid Product Id";
      }
    });
    print("{Main Status}" + status);

    return status;
  }

  sendError(Error) {
    //print(Error);
  }

  Future<String> AfterSellingUpdateQuantity(
      {id, quantity, customer, sellingQuantity, productQuantity}) async {
    print("1");
    var status = '';
    SharedPreferences p = await SharedPreferences.getInstance();
    var shop = p.getString('shop-name');
    var manager=p.getString('shop-manager');
    try {
      print("2");
      await shops
          .doc(shop)
          .collection("products")
          .doc(id)
          .update({
            "product_quantity": quantity.toString().trim(),
            "_last_updated": FieldValue.arrayUnion([
              {
                'updated_by': manager,
                'updated_shop':shop,
                'changes': "Selled to " +
                    customer.name +
                    " => " +
                    customer.mobile.toString() +
                    " by " +
                    " manager " +
                    "( " +
                    "( " +
                    sellingQuantity.toString() +
                    " => " +
                    "( " +
                    productQuantity.toString() +
                    " ) " +
                    "( " +
                    quantity.toString() +
                    " ) " +
                    " ) " +
                    " ) ",
                'updated_at': DateTime.now().toString(),
              }
            ])
          })
          .then((value) => {

                status = "Done",
              })
          .catchError(
            (error) {

              status = "Error";
            },
          );

      return status;
    } catch (e) {
      print(e);
      status = "Error";
      return status;
    }
  }

  Future<String> GenerateBill(
      {customer,
      id,
      toalPrice,
      quantity,
      paymentMode,
      customerSellingPrice,
      internalSellingPrice,
      documentSnapshot}) async {
    var status = "";

    final date = DateTime.now();
    final dueDate = date.add(Duration(days: 7));
    var productModel = documentSnapshot['product_model'] ?? "";
    var productRam = documentSnapshot['product_ram'] ?? "0";
    var productStorage = documentSnapshot['product_storage'] ?? "0";
    var productPrice = documentSnapshot['product_price'] ?? "None";
    var productQuantity = documentSnapshot['product_quantity'] ?? "0";
    var productBrand = documentSnapshot['product_brand'] ?? "0";
    try {
      final invoice = Invoice(
        supplier: Supplier(
          name: 'Shop Name',
          address: 'Shop address',
          paymentInfo: 'Thank you for shopping',
        ),
        customer: BillCustomer(
          mail: customer.mail,
          mobile: customer.mobile,
          name: customer.name,
          address: customer.address,
        ),
        info: InvoiceInfo(
          date: date,
          dueDate: dueDate,
          description: 'My description...',
          number: '${DateTime.now().year}',
        ),
        items: [
          InvoiceItem(
              description: productBrand +
                  " " +
                  productModel +
                  " " +
                  productRam +
                  " " +
                  productStorage +
                  " ",
              quantity: int.parse(quantity),
              gst: 19,
              unitPrice: double.parse(customerSellingPrice),
              priceInWords: NumberToWord()
                  .convert('en-in', int.parse(customerSellingPrice))),
        ],
      );

      final pdfFile = await PdfInvoiceApi.generate(invoice);
      await PdfApi.uploadFile(pdfFile,
              path:
                  "shop/${date}/${customer.mobile}/${id}/${productBrand + " " + productModel + " " + productRam + " " + productStorage + " "}.pdf",
              date: date,
              CustomerMobile: customer.mobile)
          .then((value) => {
                if (value != "Error")
                  {
                    status = "Uploaded",
                    status = value,
                    // PdfApi.openFile(pdfFile)
                  }
                else
                  {status = "[Upload File ]Error]"}
              });
    } catch (e) {
      print("[Customer Firebase Error 253] " + e.toString());
      status = "Error";
    }
    return status;
  }
}

//  //print(productModel +
//       productRam +
//       productStorage +
//       productPrice +
//       productQuantity +
//       productBrand);

//       await FirebaseFirestore.instance
//     .collection('shops')
//     .doc("shop")
//     .collection("sells")
//     .doc('2021-11-04')
//     .get()
//     .then((DocumentSnapshot document) {
//   //print(document['9505501046']);
// });
