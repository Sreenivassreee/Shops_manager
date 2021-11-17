import 'package:flutter/cupertino.dart';
import 'package:shops_manager/export.dart';
import 'package:shops_manager/widgets/global/cuperLoading.dart';
import 'package:shops_manager/widgets/global/toast.dart';

class AdminAddShop extends StatefulWidget {
  const AdminAddShop({Key? key}) : super(key: key);

  @override
  State<AdminAddShop> createState() => _AdminAddShopState();
}

class _AdminAddShopState extends State<AdminAddShop> {
  Fire fire = Fire();
  TextEditingController shopId = TextEditingController();
  TextEditingController managerName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  var _isActive = false;
  var isAdmin = false;
  var error = "";
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? Scaffold(body: cuperLoading())
        : Scaffold(
            appBar: app_bar(title: "Add Shop"),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "CUSTOMER DETAILS",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        controller: shopId,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Shop id  (Unique)',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        controller: managerName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Manager Name',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: password,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: phoneNumber,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Manager Phone Number',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Manager in Active"),
                          CupertinoSwitch(
                            trackColor: Colors.red,
                            activeColor: Colors.green,
                            value: _isActive,
                            onChanged: (bool value) {
                              setState(() {
                                _isActive = !_isActive;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Admin ?"),
                            CupertinoSwitch(
                              trackColor: Colors.red,
                              activeColor: Colors.green,
                              value: isAdmin,
                              onChanged: (bool value) {
                                setState(() {
                                  isAdmin = !isAdmin;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: btn(
              btnTitle: "CREATE SHOP",
              action: () async {
                setState(() {
                  isLoading = true;
                });
                if (shopId.text.isEmpty ||
                    managerName.text.isEmpty ||
                    password.text.isEmpty ||
                    phoneNumber.text.isEmpty) {
                  show(context, "Please provide valid info");
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  await fire.AddShop(
                          shopId: shopId.text,
                          managerName: managerName.text,
                          password: password.text,
                          phoneNumber: phoneNumber.text,
                          isActive: _isActive,
                          isAdmin: isAdmin)
                      .then((v) {
                    if (v == "AlreadyUser") {
                      error = "AlreadyUser";
                      setState(() {
                        isLoading = false;
                      });
                      show(context, error);
                    } else if (v == "error") {
                      error = "Error";
                      setState(() {
                        isLoading = false;
                      });
                      show(context, error);
                    } else if (v == "Added") {
                      setState(() {
                        isLoading = false;
                      });

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AdminHomepage(),
                          ),
                          (route) => false);
                    }
                  });
                }

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext context) => PaymmentScreen(),
                //   ),
                // );
              },
            ),
          );
  }
}
