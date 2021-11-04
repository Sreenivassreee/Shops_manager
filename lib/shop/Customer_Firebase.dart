import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shops_manager/shop/models/customer.dart';

class CFireBase {
  CollectionReference shops = FirebaseFirestore.instance.collection('shops');
  SellProduct(
      {customer,
      id,
      toalPrice,
      quantity,
      paymentMode,
      customerSellingPrice}) async {
    print(id);
    print(customer);
    print(quantity);
    print(toalPrice);
    var status = "";

    await FirebaseFirestore.instance
        .collection('shops')
        .doc("shop")
        .collection("products")
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        DateTime dateToday = new DateTime.now();
        String date = dateToday.toString().substring(0, 10);
        print(date);
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
          lastUpdated = [lastUpdated.length - 1];
        } catch (e) {
          status = "Unknows Error ";
        }
        if (isDeleted == false) {
          if (int.parse(productQuantity) > 0) {
            if (int.parse(productQuantity) >= int.parse(quantity)) {
              await shops.doc("shop").collection('sells').doc("test").update({
                customer.mobile: FieldValue.arrayUnion([
                  {
                    "name": customer.name,
                    "mobile": customer.mobile,
                    "mail": customer.mail,
                    "address": customer.address,
                    "buy_products": FieldValue.arrayUnion([
                      {
                        "selling_price": customerSellingPrice,
                        "payment_mode": paymentMode,
                        "total_price": toalPrice,
                        "sell_by_manager": "sell_by_manager",
                        "time_stamp": DateTime.now(),
                        "storage": productStorage,
                        "sell_by_shop": "shop",
                        "quantity": quantity,
                        "model": productModel,
                        "_id": id,
                        "bill_url": "bill_url",
                        "brand": productBrand,
                        "ram": productRam,
                        "past_product_details": FieldValue.arrayUnion([
                          {
                            "quantity": productQuantity,
                            "last_updated": lastUpdated,
                            "model": productModel,
                            "storage": productStorage,
                            "brand": productBrand,
                            "ram": productRam,
                          },
                        ]),
                      }
                    ]),
                  }
                ])
              }).then((value) => status = "Added");
            } else {
              print("Here");
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
    print(status);
  }

  sendError(Error) {
    print(Error);
  }
}
      //  print(productModel +
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
    //   print(document['9505501046']);
    // });