import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shops_manager/admin/Screens/admin_home_screen.dart';

import 'package:shops_manager/widgets/btn.dart';
import 'package:shops_manager/widgets/title_text.dart';

import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var error = '';
  @override
  void initState() {
    super.initState();
  }

  Future<String> get({shopName, userName, password}) async {
    var typeOfUser;
    CollectionReference users =
        await FirebaseFirestore.instance.collection('users');
    await users.doc(shopName).get().then((v) {
      if (v['user_name'] == userName && v['password'] == password) {
        if (v['is_admin']) {
          typeOfUser = "admin";
          print(typeOfUser);
        } else {
          typeOfUser = "manager";
          print(typeOfUser);
        }
        setState(() {
          error = '';
        });
      } else {
        setState(() {
          error = "Your Cretentials are Wrong";
        });
      }
    });

    return await typeOfUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            TitleText(
              title: "Login",
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: shopNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Shop Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: userNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: Text('Forgot Password'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                error,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
            btn(
                btnTitle: "Login",
                action: () async {
                  // Direct Login
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AdminHomepage(),
                    ),
                  );
                  // if (shopNameController.text.isEmpty ||
                  //     userNameController.text.isEmpty ||
                  //     passwordController.text.isEmpty) {
                  //   setState(() {
                  //     error = "Please provide valid Cretentials";
                  //   });
                  // } else {

                  //   await get(
                  //           shopName: shopNameController.text,
                  //           userName: userNameController.text,
                  //           password: passwordController.text)
                  //       .then((v) {
                  //     print("v");
                  //     print(v);
                  //     if (v != null) {
                  //       print(v);
                  //       if (v == 'admin') {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (BuildContext context) =>
                  //                 AdminHomepage(),
                  //           ),
                  //         );
                  //       } else if (v == 'manager') {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (BuildContext context) => Homepage(),
                  //           ),
                  //         );
                  //       }
                  //     } else {
                  //       setState(() {
                  //         error = 'Invalid Error';
                  //       });
                  //     }
                  //   });
                  // }
                }),
            // Container(
            //   child: Row(
            //     children: <Widget>[
            //       Text('Does not have account?'),
            //       TextButton(
            //         child: Text(
            //           'Sign in',
            //           style: TextStyle(fontSize: 20),
            //         ),
            //         onPressed: () {
            //           //signup screen
            //         },
            //       )
            //     ],
            //     mainAxisAlignment: MainAxisAlignment.center,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
