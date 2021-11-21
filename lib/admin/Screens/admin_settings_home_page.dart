import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shops_manager/export.dart';

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
                  title: "Settings",
                  action: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AdminAddShop(),
                      ),
                    );
                  }),
              Card(
                child: Text("Add Shops2"),
              ),
              Card(
                child: Text("Add Shops"),
              ),
              Card(
                child: Text("Add Shops2"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget SettingTile({context, title, action}) {
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
                  Icon(CupertinoIcons.right_chevron),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
