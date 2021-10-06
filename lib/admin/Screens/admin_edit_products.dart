import 'package:shops_manager/admin/Screens/admin_final_alert.dart';
import 'package:shops_manager/export.dart';

class AdminEditProducts extends StatelessWidget {
  const AdminEditProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: btn(
        btnTitle: "NEXT",
        action: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => AdminFinalAlert(),
          ),
        ),
      ),
      appBar: app_bar(title: "{Shop Name}", actionText: "Edit"),
      body: Container(
        padding: EdgeInsets.all(0),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone model',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'ram',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Storage',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Price',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Quantity',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
