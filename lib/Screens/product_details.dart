import 'package:flutter/material.dart';
import 'package:shops_manager/widgets/button.dart';
import 'package:shops_manager/widgets/t_button.dart';
import 'package:shops_manager/widgets/title_text.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: 120,
        child: Column(
          children: [
            btn(
              btnTitle: "SELE",
              action: () {},
            ),
            tBtn(
              btnTitle: "SEND TO ANOTHER STORE",
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                title: "MI Note 4 ",
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text(
                  "100",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Brand : MI",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Model : Note 10",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Ram : 2gb ",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Storage : 32gb ",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "MRP : 10,000/-",
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
                Text(
                  "Available Stock : 100",
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
