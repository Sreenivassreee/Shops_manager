import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shops_manager/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:shops_manager/shop/shared-pref/shop-shared-pref.dart';
import 'package:shops_manager/widgets/global/cuperLoading.dart';

class AdminSettingsHomePage extends StatelessWidget {
  const AdminSettingsHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(title: "Settings"),
      body: Container(
        child: Center(
          child: Column(
            children: [
              SettingTile(
                  context: context,
                  title: "Add Shop",
                  
                  action: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AdminAddShop(),
                      ),
                    );
                  }),
                  Spacer(),
                   SettingTile(
                  context: context,
                  title: "Signout",
                  icon:false,
                  action: () {
                    logout();
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
                  }),
             
            ],
          ),
        ),
      ),
    );
  }

  Widget SettingTile({context, title, action,icon=true}) {
    return InkWell(
      onTap: action,
      child: Container(
        width: MediaQuery.of(context).size.width - 10,
        margin: EdgeInsets.all(10),
        height: 60,
        child: Card(
          elevation: 0,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title),
                 icon==true? Icon(CupertinoIcons.right_chevron):SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
