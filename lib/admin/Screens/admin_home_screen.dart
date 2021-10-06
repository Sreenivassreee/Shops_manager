import 'package:shops_manager/export.dart';

class AdminHomepage extends StatelessWidget {
  const AdminHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(title: 'Shops'),
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
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ABC Shop ${index}",
                        style: TextStyle(fontSize: 25, color: Colors.green),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Shop Manager : Sreenivas K",
                        style: TextStyle(
                          fontSize: 15,
                        ),
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
