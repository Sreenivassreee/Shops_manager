import 'package:flutter/material.dart';
import 'package:shops_manager/Screens/home_screen.dart';
import 'package:shops_manager/widgets/btn.dart';
import 'package:shops_manager/widgets/title_text.dart';

import 'home_screen.dart';

class LoginPage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                controller: nameController,
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
            btn(
              btnTitle: "Login",
              action: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Homepage(),
                ),
              ),
            ),
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
