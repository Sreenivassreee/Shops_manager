import 'dart:math';

import 'package:shops_manager/export.dart';

class Fire {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference shops = FirebaseFirestore.instance.collection('shops');
  Future<String> ValidateLogin({shopName, userName, password}) async {
    var typeOfUser;
    try {
      await users.doc(shopName).get().then((v) {
        if (v['user_name'] == userName && v['password'] == password) {
          if (v['_is_active']) {
            if (v['is_admin']) {
              typeOfUser = "admin";
              print(typeOfUser);
              return typeOfUser;
            } else {
              typeOfUser = "manager";
              print(typeOfUser);
              return typeOfUser;
            }
          } else {
            typeOfUser = "blocked";
            return typeOfUser;
          }
        } else {
          print("Your Cretentials are Wrong");
          typeOfUser = "notFound";
          return typeOfUser;
        }
      });
      return typeOfUser;
    } catch (e) {
      print(e);
      typeOfUser = "notFound";
      return typeOfUser;
    }
  }

  Future<String> AddShop(
      {shopId, managerName, password, phoneNumber, isActive, isAdmin}) async {
    var status = '';
    try {
      shopId = shopId.toLowerCase();
      await users.doc(shopId).get().then((v) {
        if (v.exists) {
          status = "AlreadyUser";
        } else {
          users
              .doc(shopId)
              .set({
                'shop_name': shopId,
                'user_name': managerName.toString(),
                'password': password.toString(),
                '_is_active': isActive,
                'is_admin': isAdmin,
                'phone_number': phoneNumber.toString(),
                'time_stamp': DateTime.now()
              }, SetOptions(merge: true))
              .then((value) => {
                    if (!isAdmin)
                      {
                        shops
                            .doc(shopId)
                            .set({
                              'shop_name': shopId,
                              'user_name': managerName.toString(),
                              'time_stamp': DateTime.now()
                            }, SetOptions(merge: true))
                            .then((value) => status = "Added")
                            .catchError((error) => status = "error")
                      },
                  })
              .catchError((error) {
                status = "error";
              });
        }
      });
      return status;
    } catch (e) {
      print(e);
      status = "Error";
      return status;
    }
  }

  Future<String> AddProductToShop(
      {shopName, brand, phoneModel, ram, storage, price, quantity}) async {
    var status = '';
    try {
      if (shopName == null) {
        status = "NoShop";
      } else {
        await shops.doc(shopName).set({
          "products": FieldValue.arrayUnion([
            {
              "product_brand": brand.toString().toLowerCase().trim(),
              "product_model": phoneModel.toString().trim(),
              "product_price": price.toString().trim(),
              "product_ram": ram.toString().trim(),
              "product_storage": storage.toString().trim(),
              "product_quantity": quantity.toString().trim(),
              "_last_updated": DateTime.now()
            }
          ])
        }, SetOptions(merge: true)).then((value) => {status = "Done"});
      }
      return status;
    } catch (e) {
      print(e);
      status = "Error";
      return status;
    }
  }

  Future<String> EditProductToShop(
      {shopName, brand, phoneModel, ram, storage, price, quantity}) async {
    var status = '';
    try {
      if (shopName == null) {
        status = "NoShop";
      } else {
        await shops.doc(shopName).update({
          "product_brand": brand.toString().toLowerCase().trim(),
          "product_model": phoneModel.toString().trim(),
          "product_price": price.toString().trim(),
          "product_ram": ram.toString().trim(),
          "product_storage": storage.toString().trim(),
          "product_quantity": quantity.toString().trim(),
          "_last_updated": DateTime.now()
        }).then((value) => {status = "Done"});
      }
      return status;
    } catch (e) {
      print(e);
      status = "Error";
      return status;
    }
  }

//Admin Add Shoop method
// Future<bool>AddShop(){
//   return true;

// }

}
