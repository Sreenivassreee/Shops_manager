import 'package:flutter/material.dart';
import 'package:shops_manager/Screens/product_details.dart';
import 'package:shops_manager/widgets/title_text.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TitleText(
            title: "Mi",
          ),
          Container(
            height: MediaQuery.of(context).size.height - 90,
            // child: GridView.count(
            //   crossAxisCount: 2,
            //   childAspectRatio: (1 / .4),
            //   shrinkWrap: true,
            //   children: List.generate(6, (index) {
            //     return Padding(
            //       padding: const EdgeInsets.all(10.0),
            //       child: Container(
            //         color: Colors.grey[600],
            //         child: Row(
            //           children: [],
            //         ),
            //       ),
            //     );
            //   }),
            // ),
            child: GridView.builder(
              itemCount: 22,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (1 / .6),
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ProductDetails(),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Note 4 2gb 64gb",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Stock",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.black,
                                      child: Text("100"),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 5),
                              Text("MRP : 10,000/-"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
