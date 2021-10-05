import '/export.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(title: 'MI NOTE 10', actionText: "100"),
      bottomSheet: Container(
        height: 120,
        child: Column(
          children: [
            btn(
              btnTitle: "SELE",
              action: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SalePage(),
                  ),
                );
              },
            ),
            tBtn(
              btnTitle: "SEND TO ANOTHER STORE",
              action: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SendToAnotherShop(),
                  ),
                );
              },
            )
          ],
        ),
      ),
      body: ListView(
        children: [
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
