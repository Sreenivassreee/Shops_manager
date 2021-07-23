import 'package:flutter/material.dart';
import 'package:shops_manager/widgets/button.dart';
import 'package:shops_manager/widgets/t_button.dart';
import 'package:shops_manager/widgets/title_text.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TitleText(title: "Stock"),
          Container(
            height: MediaQuery.of(context).size.height - 250,
            child: GridView.builder(
              itemCount: 100,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return new Card(
                  child: Center(
                    child: Text("MI"),
                  ),
                );
              },
            ),
          ),
          btn(
            btnTitle: "TODAY SALES",
            action: () {},
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: tBtn(
                  btnTitle: "TODAY EXCHANGES",
                  action: () {},
                ),
              ),
              tBtn(
                btnTitle: "ACCEPT CHNAGES",
                action: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
