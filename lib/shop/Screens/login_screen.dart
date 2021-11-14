import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shops_manager/admin/Screens/admin_home_screen.dart';
import 'package:shops_manager/admin/firebase/fire.dart';

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
  Fire fire = Fire();
  var error = '';
  @override
  void initState() {
    super.initState();
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
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            btn(
                btnTitle: "Login",
                action: () async {
                  setState(() {
                    error = '';
                  });
                  // Direct Login
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) => Homepage(
                  //       shopName: "shop",
                  //       userName: "Userstock",
                  //     ),
                  //   ),
                  // );
                  if (shopNameController.text.isEmpty ||
                      userNameController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    setState(() {
                      error = "Please provide valid Cretentials";
                    });
                  } else {
                    fire.ValidateLogin(
                            shopName: shopNameController.text,
                            userName: userNameController.text,
                            password: passwordController.text)
                        .then((v) {
                      if (v != Null) {
                        if (v == 'admin') {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AdminHomepage()),
                              ModalRoute.withName(''));
                        } else if (v == 'manager') {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Homepage()),
                              ModalRoute.withName(''));
                        } else if (v == "notFound") {
                          setState(() {
                            error = "Invalid cretentials";
                          });
                        } else if (v == "blocked") {
                          setState(() {
                            error = "Blocked by Admin";
                          });
                        }
                      } else {
                        setState(() {
                          error = 'Invalid Error';
                        });
                      }
                    });
                  }
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
