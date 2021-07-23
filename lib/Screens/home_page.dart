import 'package:flutter/material.dart';
import 'package:shops_manager/Screens/product_page.dart';
import 'package:shops_manager/widgets/button.dart';
import 'package:shops_manager/widgets/t_button.dart';
import 'package:shops_manager/widgets/title_text.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int data = 21;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
          height: 120,
          child: Column(
            children: [
              btn(
                btnTitle: "TODAY SALES",
                action: () {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tBtn(
                    btnTitle: "TODAY EXCHANGES",
                    action: () {},
                  ),
                  tBtn(
                    btnTitle: "ACCEPT CHNAGES",
                    action: () {},
                  ),
                ],
              )
            ],
          )),
      body: ListView(
        children: [
          TitleText(title: "Stock"),
          Container(
            height: MediaQuery.of(context).size.height - 210,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: data + 3,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return data > index
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => ProductPage(),
                            ),
                          );
                        },
                        child: new Card(
                          elevation: 0,
                          child: Center(
                            child: Text("MI +$index"),
                          ),
                        ),
                      )
                    : Container(
                        child: SizedBox(
                          height: 100,
                        ),
                      );
              },
            ),
          ),
          SizedBox(
            height: 200,
          )
        ],
      ),
    );
  }
}
