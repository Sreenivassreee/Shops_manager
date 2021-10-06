import 'package:shops_manager/export.dart';

class AdminSalesReport extends StatelessWidget {
  const AdminSalesReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TitleText(
          title: "1000000000/-",
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(
                Icons.attach_money_sharp,
                color: Colors.white,
              ),
            ),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 50,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => AdminBrandProductScreen(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
              child: Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Brand : MI  ${index}",
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Model : Sreenivas K",
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Ram : Sreenivas K",
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Storage : Sreenivas K",
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "MRP : 10,000/-",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("10/10/1999 12.00pm"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
