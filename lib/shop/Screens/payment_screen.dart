import '/export.dart';
import 'final_alert.dart';

class PaymmentScreen extends StatelessWidget {
  const PaymmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TitleText(title: "Payment Type"),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 15),
            child: Text(
              "Total Amount : 10,000/-",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          btn(
            btnTitle: "CASH",
            action: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => FinalAlert(),
                ),
              );
            },
          ),
          btn(
            btnTitle: "CARD",
            action: () {},
          ),
          btn(
            btnTitle: "PHONE PAY",
            action: () {},
          ),
          btn(
            btnTitle: "G PAY",
            action: () {},
          ),
          btn(
            btnTitle: "EMI",
            action: () {},
          ),
        ],
      ),
    );
  }
}

class FinalAlertScreen {}
