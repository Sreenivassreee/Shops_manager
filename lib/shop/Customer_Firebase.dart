import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shops_manager/shop/models/cus.dart';

class CFireBase {
  CollectionReference shops = FirebaseFirestore.instance.collection('shops');
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

    await shops
        .doc("shop")
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
              await shops.doc("shop").collection('sells').doc("test").set({
                customer.mobile: FieldValue.arrayUnion([
                  {
                    "customer_details": {
                      "name": customer.name,
                      "mobile": customer.mobile,
                      "mail": customer.mail,
                      "address": customer.address,
                    },
                    "buy_products": {
                      "now_mrp_selling_price": customerSellingPrice,
                      "now_payment_mode": paymentMode,
                      "now_total_price": toalPrice,
                      "now_sell_by_manager": "sell_by_manager",
                      "now_time_stamp": DateTime.now(),
                      "now_storage": productStorage,
                      "now_sell_by_shop": "shop",
                      "now_quantity": quantity,
                      "now_model": productModel,
                      "now__id": id,
                      "now_bill_url": "bill_url",
                      "now_brand": productBrand,
                      "now_ram": productRam,
                      "now_internal_selling_price": internalSellingPrice
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
              }, SetOptions(merge: true)).then((value) async {
                // generateBill(){}.then((value) {});
                await AfterSellingUpdateQuantity(
                        id: id,
                        sellingQuantity: quantity,
                        productQuantity: productQuantity,
                        quantity:
                            int.parse(productQuantity) - int.parse(quantity),
                        customer: customer)
                    .then((value) => {
                          if (value == "Done")
                            {
                              status = "TransactionCompleted",
                            }
                          else
                            {status = value}
                        });
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
    return status;
    //print(status);
  }

  sendError(Error) {
    //print(Error);
  }

  Future<String> AfterSellingUpdateQuantity(
      {id, quantity, customer, sellingQuantity, productQuantity}) async {
    print("1");
    var status = '';
    try {
      print("2");
      await shops
          .doc("shop")
          .collection("products")
          .doc(id)
          .update({
            "product_quantity": quantity.toString().trim(),
            "_last_updated": FieldValue.arrayUnion([
              {
                'updatedBy': "NeedToAdd",
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
                'timestamp': DateTime.now().toString(),
              }
            ])
          })
          .then((value) => {
                print("3"),
                status = "Done",
              })
          .catchError(
            (error) {
              print("4");
              status = "Error";
            },
          );

      return status;
    } catch (e) {
      print("5");
      print(e);
      status = "Error";
      return status;
    }
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