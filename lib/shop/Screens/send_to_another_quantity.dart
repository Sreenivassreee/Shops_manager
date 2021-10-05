import 'package:shops_manager/export.dart';

class SendToAnotherQuantity extends StatelessWidget {
  const SendToAnotherQuantity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: btn(
        btnTitle: "SEND",
        action: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Homepage(),
            ),
          );
        },
      ),
      body: ListView(
        children: [
          TitleText(
            title: "Quantity",
          ),
          TitleText(
            title: "MI Note 10",
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
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Quantity :",
                        style: TextStyle(fontSize: 25, color: Colors.green),
                      ),
                      Container(
                        width: 150,
                        child: Flexible(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Quantity',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
